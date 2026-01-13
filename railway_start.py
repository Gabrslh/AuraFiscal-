#!/usr/bin/env python3
"""Railway startup script - replaces bash to avoid CRLF issues."""
import os
import subprocess
import sys

print("🚀 Iniciando NFS-e Automation System...")

# Get PORT from environment
port = os.environ.get("PORT", "8501")
print(f"PORT={port}")

# Run certificate initialization
print("📜 Inicializando certificados...")
result = subprocess.run([sys.executable, "railway_init.py"], capture_output=True, text=True)
print(result.stdout)
if result.stderr:
    print(result.stderr)

# Start Streamlit
print(f"🌐 Iniciando Streamlit na porta {port}...")
os.execvp(
    sys.executable,
    [
        sys.executable, "-m", "streamlit", "run",
        "app_nfse_enhanced.py",
        "--server.port", port,
        "--server.address", "0.0.0.0",
        "--server.headless", "true",
        "--server.enableCORS", "false",
        "--server.enableXsrfProtection", "false"
    ]
)
