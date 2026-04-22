from flask import Flask, render_template
from datetime import datetime

app = Flask(__name__)

# Dados Fictícios - Google Cloud Tech Day
TALKS = [
    {
        "id": 1,
        "title": "A Jornada para a Nuvem: Cloud Adoption Framework",
        "speakers": [
            {"first_name": "Juliana", "last_name": "Silva", "linkedin": "https://www.linkedin.com/in/juliana-silva-cloud/"},
            {"first_name": "Marcos", "last_name": "Oliveira", "linkedin": "https://www.linkedin.com/in/marcos-oliveira-tech/"}
        ],
        "category": "Cloud Strategy",
        "description": "Explorando os pilares de adoção de nuvem para empresas que buscam modernização e agilidade.",
        "time": "09:00 - 10:00"
    },
    {
        "id": 2,
        "title": "Mastering Kubernetes com GKE Autopilot",
        "speakers": [
            {"first_name": "Ricardo", "last_name": "Santos", "linkedin": "https://www.linkedin.com/in/ricardo-santos-k8s/"}
        ],
        "category": "DevOps & Containers",
        "description": "Como simplificar a gestão de containers e focar no que importa: seu código.",
        "time": "10:00 - 11:00"
    },
    {
        "id": 3,
        "title": "IA Generativa no Google Cloud: O Futuro com Vertex AI",
        "speakers": [
            {"first_name": "Ana", "last_name": "Costa", "linkedin": "https://www.linkedin.com/in/ana-costa-ai/"},
            {"first_name": "Felipe", "last_name": "Pereira", "linkedin": "https://www.linkedin.com/in/felipe-pereira-ml/"}
        ],
        "category": "AI & Machine Learning",
        "description": "Uma demonstração prática de como construir e implementar modelos de IA generativa em escala.",
        "time": "11:00 - 12:00"
    },
    {
        "id": 4,
        "title": "BigQuery: Do Zero ao Dashboard em Minutos",
        "speakers": [
            {"first_name": "Beatriz", "last_name": "Mendes", "linkedin": "https://www.linkedin.com/in/beatriz-mendes-data/"}
        ],
        "category": "Data Analytics",
        "description": "Análise de petabytes de dados quase instantaneamente usando o poder do BigQuery.",
        "time": "12:00 - 13:00"
    },
    {
        "id": 5,
        "title": "Intervalo para Almoço",
        "speakers": [],
        "category": "Network",
        "description": "Recarregue as energias e faça networking com outros entusiastas de tecnologia.",
        "time": "13:00 - 14:00",
        "is_break": True
    },
    {
        "id": 6,
        "title": "Segurança na Nuvem: Protegendo sua Infraestrutura com Cloud Armor",
        "speakers": [
            {"first_name": "Tiago", "last_name": "Albuquerque", "linkedin": "https://www.linkedin.com/in/tiago-albuquerque-sec/"}
        ],
        "category": "Security",
        "description": "Melhores práticas para mitigar ataques DDoS e proteger APIs.",
        "time": "14:00 - 15:00"
    },
    {
        "id": 7,
        "title": "Serverless sem segredos: Cloud Run para APIs Modernas",
        "speakers": [
            {"first_name": "Clara", "last_name": "Lopes", "linkedin": "https://www.linkedin.com/in/clara-lopes-dev/"},
            {"first_name": "Gabriel", "last_name": "Souza", "linkedin": "https://www.linkedin.com/in/gabriel-souza-serverless/"}
        ],
        "category": "App Development",
        "description": "Construindo aplicações web escaláveis e eficientes sem gerenciar servidores.",
        "time": "15:00 - 16:00"
    },
    {
        "id": 8,
        "title": "Modernização de Apps com Firebase e Gemini",
        "speakers": [
            {"first_name": "Hugo", "last_name": "Vieira", "linkedin": "https://www.linkedin.com/in/hugo-vieira-firebase/"}
        ],
        "category": "App Development",
        "description": "Turbine seus aplicativos móveis e web com as novas funcionalidades de IA do Firebase.",
        "time": "16:00 - 17:00"
    },
    {
        "id": 9,
        "title": "Multicloud Resiliente com Anthos",
        "speakers": [
            {"first_name": "Renata", "last_name": "Martins", "linkedin": "https://www.linkedin.com/in/renata-martins-cloud/"}
        ],
        "category": "Hybrid & Multicloud",
        "description": "Como gerenciar clusters Kubernetes em diferentes ambientes de forma unificada.",
        "time": "17:00 - 18:00"
    },
    {
        "id": 10,
        "title": "Observabilidade Proativa: SRE com Google Cloud Operations",
        "speakers": [
            {"first_name": "Letícia", "last_name": "Ramos", "linkedin": "https://www.linkedin.com/in/leticia-ramos-sre/"}
        ],
        "category": "DevOps & Operations",
        "description": "Aprendendo a usar Cloud Monitoring e Logging para antecipar falhas e garantir alta disponibilidade.",
        "time": "18:00 - 19:00"
    },
    {
        "id": 11,
        "title": "Edge Computing: Estendendo o Cloud para a Ponta com Anthos",
        "speakers": [
            {"first_name": "Bruno", "last_name": "Oliveira", "linkedin": "https://www.linkedin.com/in/bruno-oliveira-edge/"},
            {"first_name": "Marissa", "last_name": "Fisher", "linkedin": "https://www.linkedin.com/in/marissafisher29"}
        ],
        "category": "Hybrid & Multicloud",
        "description": "Como levar o poder do Google Cloud para ambientes on-premises e dispositivos de borda.",
        "time": "19:00 - 20:00"
    }
]

@app.route('/')
def index():
    now = datetime.now()
    event_data = {
        "name": "Google Cloud Tech Day",
        "date": "24 de Outubro, 2026",
        "location": "Google São Paulo, Itaim Bibi",
        "current_time": now.strftime("%H:%M")
    }
    return render_template('index.html', event=event_data, talks=TALKS)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
