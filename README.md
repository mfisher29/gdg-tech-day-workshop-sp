# Build With AI São Paulo - Site da Conferência (PT)

Este repo consiste de um site de conferência técnica de 1 dia usando tecnologias Google Cloud. O projeto utiliza **Python/Flask** no backend e uma interface moderna com **HTML, CSS e JavaScript** (Vanilla).

**IMPORTANTE:** Para os participantes do workshop, sigam as instruções detalhadas nos slides da apresentação. Este código serve como um exemplo do que pode ser construído. Caso você já possua um projeto no Google Cloud, pode subir este código exatamente como está usando seus próprios IDs de projeto e contas de faturamento.

## 🚀 Funcionalidades

- **Cronograma Dinâmico**: Lista de 11 palestras técnicas + intervalo de almoço.
- **Busca em Tempo Real**: Filtre palestras por categoria, palestrante ou título instantaneamente.
- **Design Premium**: Interface baseada em Glassmorphism com tema dark/light e cores vibrantes do Google Cloud.
- **Responsividade**: Totalmente adaptado para dispositivos móveis e desktops.

## 🛠️ Tecnologias Utilizadas

- **Backend**: Python 3.x, Flask
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Deployment**: Google Cloud Run & Firebase Hosting

## 📋 Como Configurar e Rodar Localmente

### Pré-requisitos
- Python 3.8 ou superior instalado.

### Passo a Passo

1. **Instalação das Dependências**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Execução Local**:
   ```bash
   python app.py
   ```
   Acesse em `http://localhost:8080`.

## 📦 Implantação (Deployment)

Para colocar o site no ar, preparamos scripts automatizados para todos os sistemas operacionais:

### Mac / Linux
1. Garanta que tem o `gcloud` CLI instalado.
2. Execute `./deploy.sh`.

### Windows
1. Abra o **PowerShell** como Administrador.
2. (Opcional) Se receber um erro de permissão, execute: 
   `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Execute `.\deploy.ps1`.

Siga as instruções no terminal (em Português!) para configurar o faturamento e finalizar a implantação.

---

# Build With AI São Paulo - Conference Website (EN)

This repo consists of a 1-day technical conference website using Google Cloud technologies. The project uses **Python/Flask** on the backend and a modern interface with **HTML, CSS, and JavaScript** (Vanilla).

**IMPORTANT:** For workshop participants, please follow the detailed instructions in the workshop slides. This code serves as an example of what can be built. If you already have a Google Cloud project, you can deploy this code as-is using your own project IDs and billing accounts.

## 🚀 Features

- **Dynamic Schedule**: List of 11 technical talks + lunch break.
- **Real-time Search**: Filter talks by category, speaker, or title instantly.
- **Premium Design**: Glassmorphism-based interface with dark/light themes and vibrant Google Cloud colors.
- **Responsiveness**: Fully adapted for mobile and desktop devices.

## 🛠️ Technologies Used

- **Backend**: Python 3.x, Flask
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Deployment**: Google Cloud Run & Firebase Hosting

## 📋 How to Set Up and Run Locally

### Prerequisites
- Python 3.8 or higher installed.

### Step-by-Step

1. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Local Execution**:
   ```bash
   python app.py
   ```
   Access at `http://localhost:8080`.

## 📦 Deployment

To make the site live, we have automated scripts for all operating systems:

### Mac / Linux
1. Ensure you have the `gcloud` CLI installed.
2. Run `./deploy.sh`.

### Windows
1. Open **PowerShell** as Administrator.
2. (Optional) If you get a permission error, run:
   `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Run `.\deploy.ps1`.

Follow the terminal instructions to set up billing and finalize the deployment.

---
*Workshop GDG São Paulo - 2026*
