# PowerShell Script de Implantação do GDG Tech Day - São Paulo
# -----------------------------------------------------------

Clear-Host
Write-Host "🌟 Bem-vindo ao Script de Implantação do GDG Co-Lab SP! 🌟" -ForegroundColor Cyan
Write-Host "----------------------------------------------------"

# 1. Verificação de Dependências e Login
Write-Host "🔍 Verificando ferramentas e autenticação..." -ForegroundColor Gray

if (!(Get-Command gcloud -ErrorAction SilentlyContinue) -or !(Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Host "❌ ERRO: Ferramentas (gcloud ou firebase) não encontradas." -ForegroundColor Red
    exit 1
}

Write-Host "👤 Autenticando no Google Cloud..." -ForegroundColor Yellow
gcloud auth login

Write-Host "🔥 Autenticando no Firebase..." -ForegroundColor Yellow
# Verifica se a sessão está ativa
$fbLogin = firebase login --list 2>$null
if ($fbLogin -notmatch "✔") {
    firebase login
}

# 2. Seleção do Projeto
Write-Host ""
$PROJECT_ID = Read-Host "🆔 Digite o ID do seu Projeto Google Cloud"

if ([string]::IsNullOrWhiteSpace($PROJECT_ID)) {
    Write-Host "❌ ERRO: O ID do projeto não pode estar vazio." -ForegroundColor Red
    exit 1
}

gcloud config set project $PROJECT_ID

Write-Host "⚙️  Habilitando APIs necessárias..." -ForegroundColor Gray
gcloud services enable `
    run.googleapis.com `
    cloudbuild.googleapis.com `
    artifactregistry.googleapis.com `
    firebase.googleapis.com `
    firebasehosting.googleapis.com --quiet

$SERVICE_NAME = "bwai-sp-site"
$REGION = "southamerica-east1"

# 3. Implantação no Cloud Run
Write-Host "☁️  Implantando backend no Cloud Run..." -ForegroundColor Cyan
gcloud run deploy $SERVICE_NAME `
    --source . `
    --region $REGION `
    --allow-unauthenticated `
    --project $PROJECT_ID --quiet

# 4. Finalização do Firebase Hosting
Write-Host "🔥 Configurando Firebase Hosting..." -ForegroundColor Yellow

# Verifica se o projeto já é um projeto Firebase
$fbProjects = firebase projects:list 2>$null
if ($fbProjects -notmatch $PROJECT_ID) {
    Write-Host "🛠️ Ativando recursos do Firebase..." -ForegroundColor Gray
    $activate = firebase projects:addfirebase $PROJECT_ID --non-interactive 2>$null
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "⚖️  PASSO OBRIGATÓRIO: Aceite de Termos" -ForegroundColor White -BackgroundColor Red
        Write-Host "----------------------------------------------------"
        Write-Host "O Google exige que você aceite os Termos de Serviço manualmente no primeiro uso."
        Write-Host "1. Acesse: https://console.firebase.google.com/?project=$PROJECT_ID"
        Write-Host "2. Clique no botão 'Adicionar Firebase' (ou 'Link Project')."
        Write-Host "3. Siga as confirmações (pode clicar em 'Continuar' em tudo)."
        Write-Host "----------------------------------------------------"
        Read-Host "🚀 Após ver o Painel do Firebase no navegador, pressione [Enter] aqui para continuar..."
        
        Write-Host "🔄 Re-sincronizando com o Firebase..."
        firebase projects:addfirebase $PROJECT_ID --non-interactive
    }
}

# Configura arquivos locais
Write-Host "📝 Gerando arquivos de configuração..." -ForegroundColor Gray
$firebaserc = @{ projects = @{ default = $PROJECT_ID } } | ConvertTo-Json
$firebaserc | Out-File -FilePath .firebaserc -Encoding utf8

$firebaseJson = @"
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
"@
$firebaseJson | Out-File -FilePath firebase.json -Encoding utf8

Write-Host "🚀 Publicando site live..." -ForegroundColor Yellow
firebase deploy --only hosting --project $PROJECT_ID --quiet

Write-Host ""
Write-Host "----------------------------------------------------" -ForegroundColor Gray
Write-Host "✨ WORKSHOP CONCLUÍDO COM SUCESSO! ✨" -ForegroundColor Green
Write-Host "🌐 URL DO SEU SITE: https://$PROJECT_ID.web.app" -ForegroundColor Green
Write-Host "----------------------------------------------------"
Write-Host "📚 Documentação: https://cloud.google.com/run"
Write-Host "----------------------------------------------------"
