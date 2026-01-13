#!/bin/bash
echo "🚀 Iniciando NFS-e Automation System..."

# Executar inicialização (certificados)
python railway_init.py

# Iniciar Streamlit na porta do Railway
exec streamlit run app_nfse_enhanced.py \
    --server.port ${PORT:-8501} \
    --server.address 0.0.0.0 \
    --server.headless true \
    --server.enableCORS false \
    --server.enableXsrfProtection false
