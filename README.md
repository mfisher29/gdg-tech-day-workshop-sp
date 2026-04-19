# Google Cloud Tech Day - Site da Conferência

Este é um site de conferência técnica de 1 dia focado em tecnologias Google Cloud. O projeto utiliza **Python/Flask** no backend e uma interface moderna com **HTML, CSS e JavaScript** (Vanilla).

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
2. Execute `.\deploy.ps1`.

Siga as instruções no terminal (em Português!) para configurar o faturamento e finalizar a implantação.

---
*Workshop GDG São Paulo - 2026*
