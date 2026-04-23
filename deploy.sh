#!/bin/bash

echo "🌟 Bem-vindo ao Script de Implantação do GDG Co-Lab SP! 🌟"
echo "----------------------------------------------------"

# 1. Verificação de Dependências e Login
echo "🔍 Verificando ferramentas e autenticação..."

if ! command -v gcloud &> /dev/null || ! command -v firebase &> /dev/null; then
    echo "❌ ERRO: Ferramentas (gcloud ou firebase) não encontradas."
    exit 1
fi

echo "👤 Autenticando no Google Cloud..."
gcloud auth login

# Limpa o .firebaserc para evitar erro de ID de projeto inválido antes do login
echo "{}" > .firebaserc

echo "🔥 Autenticando no Firebase..."
if ! firebase login --list &> /dev/null; then
    firebase login
fi

# 2. Seleção do Projeto
echo ""
read -p "🆔 Digite o ID do seu Projeto Google Cloud: " PROJECT_ID

if [ -z "$PROJECT_ID" ]; then
    echo "❌ ERRO: O ID do projeto não pode estar vazio."
    exit 1
fi

gcloud config set project $PROJECT_ID

echo "⚙️  Habilitando APIs necessárias..."
gcloud services enable \
    run.googleapis.com \
    cloudbuild.googleapis.com \
    artifactregistry.googleapis.com \
    firebase.googleapis.com \
    firebasehosting.googleapis.com --quiet

SERVICE_NAME="bwai-sp-site"
REGION="southamerica-east1"

# 3. Implantação no Cloud Run
echo "☁️  Implantando backend no Cloud Run..."
gcloud run deploy $SERVICE_NAME \
    --source . \
    --region $REGION \
    --allow-unauthenticated \
    --project $PROJECT_ID --quiet

# 4. Finalização do Firebase Hosting
echo "🔥 Configurando Firebase Hosting..."

# Tenta vincular o projeto ao Firebase se necessário
if ! firebase projects:list 2>/dev/null | grep -q "$PROJECT_ID"; then
    echo "🛠️ Ativando recursos do Firebase..."
    if ! firebase projects:addfirebase $PROJECT_ID --non-interactive; then
        echo "⚖️  Ação necessária: Aceite os termos em https://console.firebase.google.com/?project=$PROJECT_ID"
        read -p "Pressione [Enter] após aceitar para continuar..."
        firebase projects:addfirebase $PROJECT_ID --non-interactive
    fi
fi

# Configura arquivos locais
echo "📝 Gravando projeto '$PROJECT_ID' no .firebaserc..."
echo "{\"projects\": {\"default\": \"$PROJECT_ID\"}}" > .firebaserc
cat <<EOF > firebase.json
{
  "hosting": {
    "public": "static",
    "rewrites": [
      {
        "source": "**",
        "run": {
          "serviceId": "$SERVICE_NAME",
          "region": "$REGION"
        }
      }
    ]
  }
}
EOF

echo "🚀 Publicando site live..."
firebase deploy --only hosting --project $PROJECT_ID --quiet

echo ""
echo "----------------------------------------------------"
echo "✨ WORKSHOP CONCLUÍDO COM SUCESSO! ✨"
echo "🌐 URL DO SEU SITE: https://$PROJECT_ID.web.app"
echo "----------------------------------------------------"
echo "📚 Documentação: https://cloud.google.com/run"
echo "----------------------------------------------------"
