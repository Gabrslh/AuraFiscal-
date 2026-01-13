# Dockerfile para Railway - NFS-e Automation System
FROM python:3.11-slim

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia requirements primeiro (para cache de layers)
COPY requirements.txt .

# Instala dependências Python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o resto do código
COPY . .

# Cria diretório para certificados
RUN mkdir -p certificados

# Cria script de inicialização
RUN echo '#!/bin/bash\npython railway_init.py && exec streamlit run app_nfse_enhanced.py --server.port ${PORT:-8501} --server.address 0.0.0.0 --server.headless true' > /app/start.sh && chmod +x /app/start.sh

# Expõe a porta (Railway define PORT automaticamente)
EXPOSE 8501

# Comando de inicialização (formato JSON)
ENTRYPOINT ["/bin/bash", "/app/start.sh"]
