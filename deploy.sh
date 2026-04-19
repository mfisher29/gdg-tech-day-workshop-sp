#!/bin/bash

echo "🌟 Bem-vindo ao Script de Implantação do GDG Tech Day! 🌟"
echo "----------------------------------------------------"

# 1. Verificação de Dependências
echo "🔍 Verificando ferramentas necessárias..."

if ! command -v gcloud &> /dev/null
then
    echo "❌ ERRO: O CLI 'gcloud' não está instalado."
    echo "💡 Por favor, instale em: https://cloud.google.com/sdk/docs/install"
    exit 1
fi

if ! command -v firebase &> /dev/null
then
    echo "⚠️  AVISO: O CLI 'firebase' não está instalado."
    echo "💡 Instale com: npm install -g firebase-tools"
    echo "Continuaremos apenas com o Cloud Run, mas o Firebase Hosting será ignorado."
    HAS_FIREBASE=false
else
    HAS_FIREBASE=true
fi

# 2. Seleção do Projeto
echo ""
read -p "🆔 Digite o ID do seu Projeto Google Cloud: " PROJECT_ID

if [ -z "$PROJECT_ID" ]; then
    echo "❌ ERRO: O ID do projeto não pode estar vazio."
    exit 1
fi

# Tenta criar o projeto se ele não existir
echo "🔨 Verificando/Criando projeto $PROJECT_ID..."
if ! gcloud projects describe $PROJECT_ID &> /dev/null; then
    gcloud projects create $PROJECT_ID
    echo "✅ Projeto criado com sucesso!"
    echo "⚠️  IMPORTANTE: Você PRECISA vincular uma conta de faturamento no console:"
    echo "🔗 https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"
    read -p "Pressione [Enter] depois de vincular o faturamento para continuar..."
else
    echo "✅ Usando projeto existente."
fi

SERVICE_NAME="tech-day-site"
REGION="southamerica-east1" # São Paulo

echo "🚀 Iniciando implantação para o Projeto: $PROJECT_ID"

# 3. Autenticação e Configuração do Projeto
echo "📍 Configurando o projeto para $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Sincronizar Cotas (evita o erro que você teve!)
echo "⚖️  Sincronizando cotas do projeto..."
gcloud auth application-default set-quota-project $PROJECT_ID --quiet 2>/dev/null || echo "⚠️  Nota: Não foi possível definir o projeto de cota (isso é normal se for sua primeira vez)."

# 4. Habilitar APIs necessárias do Google Cloud
echo "⚙️ Habilitando APIs necessárias (Run, Build, Registry)..."
gcloud services enable \
    run.googleapis.com \
    cloudbuild.googleapis.com \
    artifactregistry.googleapis.com \
    serviceusage.googleapis.com

# 5. Implantação no Cloud Run
echo "☁️ Implantando no Cloud Run em $REGION..."
gcloud run deploy $SERVICE_NAME \
    --source . \
    --region $REGION \
    --allow-unauthenticated \
    --project $PROJECT_ID

# 6. Finalização do Firebase Hosting
if [ "$HAS_FIREBASE" = true ] ; then
    echo "🔥 Atualizando configuração do Firebase..."
    # Atualiza o arquivo .firebaserc com o ID do projeto do usuário
    echo "{\"projects\": {\"default\": \"$PROJECT_ID\"}}" > .firebaserc
    
    echo "🔥 Implantando no Firebase Hosting..."
    firebase deploy --only hosting
fi

echo ""
echo "✨ WORKSHOP PRONTO! ✨"
echo "Seu site deve estar no ar nos URLs exibidos acima."
