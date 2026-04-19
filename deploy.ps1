# PowerShell Script de Implantação do GDG Tech Day

Write-Host "🌟 Bem-vindo ao Script de Implantação do GDG Tech Day! 🌟" -ForegroundColor Cyan
Write-Host "----------------------------------------------------"

# 1. Verificação de Dependências
Write-Host "🔍 Verificando ferramentas necessárias..."

if (!(Get-Command gcloud -ErrorAction SilentlyContinue)) {
    Write-Host "❌ ERRO: O CLI 'gcloud' não está instalado." -ForegroundColor Red
    Write-Host "💡 Por favor, instale em: https://cloud.google.com/sdk/docs/install"
    exit
}

$HAS_FIREBASE = $true
if (!(Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  AVISO: O CLI 'firebase' não está instalado." -ForegroundColor Yellow
    Write-Host "💡 Instale com: npm install -g firebase-tools"
    Write-Host "Continuaremos apenas com o Cloud Run, mas o Firebase Hosting será ignorado."
    $HAS_FIREBASE = $false
}

# 2. Seleção do Projeto
Write-Host ""
$PROJECT_ID = Read-Host "🆔 Digite o ID do seu Projeto Google Cloud"

if ([string]::IsNullOrWhiteSpace($PROJECT_ID)) {
    Write-Host "❌ ERRO: O ID do projeto não pode estar vazio." -ForegroundColor Red
    exit
}

# Tenta criar o projeto se ele não existir
Write-Host "🔨 Verificando/Criando projeto $PROJECT_ID..."
$projectExists = gcloud projects describe $PROJECT_ID 2>$null
if (!$projectExists) {
    gcloud projects create $PROJECT_ID
    Write-Host "✅ Projeto criado com sucesso!" -ForegroundColor Green
    Write-Host "⚠️  IMPORTANTE: Você PRECISA vincular uma conta de faturamento no console:" -ForegroundColor Yellow
    Write-Host "🔗 https://console.cloud.google.com/billing/linkedaccount?project=$PROJECT_ID"
    Read-Host "Pressione [Enter] depois de vincular o faturamento para continuar..."
} else {
    Write-Host "✅ Usando projeto existente." -ForegroundColor Green
}

$SERVICE_NAME = "tech-day-site"
$REGION = "southamerica-east1" # São Paulo

Write-Host "🚀 Iniciando implantação para o Projeto: $PROJECT_ID" -ForegroundColor Cyan

# 3. Autenticação e Configuração do Projeto
Write-Host "📍 Configurando o projeto para $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Sincronizar Cotas
Write-Host "⚖️  Sincronizando cotas do projeto..."
gcloud auth application-default set-quota-project $PROJECT_ID --quiet 2>$null

# 4. Habilitar APIs necessárias do Google Cloud
Write-Host "⚙️ Habilitando APIs necessárias (Run, Build, Registry)..."
gcloud services enable `
    run.googleapis.com `
    cloudbuild.googleapis.com `
    artifactregistry.googleapis.com `
    serviceusage.googleapis.com

# 5. Implantação no Cloud Run
Write-Host "☁️ Implantando no Cloud Run em $REGION..." -ForegroundColor Cyan
gcloud run deploy $SERVICE_NAME `
    --source . `
    --region $REGION `
    --allow-unauthenticated `
    --project $PROJECT_ID

# 6. Finalização do Firebase Hosting
if ($HAS_FIREBASE) {
    Write-Host "🔥 Atualizando configuração do Firebase..." -ForegroundColor Yellow
    $firebaseConfig = @{ projects = @{ default = $PROJECT_ID } } | ConvertTo-Json
    $firebaseConfig | Out-File -FilePath .firebaserc -Encoding utf8
    
    Write-Host "🔥 Implantando no Firebase Hosting..." -ForegroundColor Yellow
    firebase deploy --only hosting
}

Write-Host ""
Write-Host "✨ WORKSHOP PRONTO! ✨" -ForegroundColor Green
Write-Host "Seu site deve estar no ar nos URLs exibidos acima."
