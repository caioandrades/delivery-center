import argparse
import subprocess
import os
import sys

# ==========================================================
# 🌐 Mapeamento de workspaces por ambiente
# ==========================================================
WORKSPACE_MAP = {
    "develop": "Nomos BI DEV",
    "stagging": "Nomos BI UAT",
    "master": "Nomos BI PRD"
}


# ==========================================================
# 🔐 Função auxiliar para validar variáveis de ambiente
# ==========================================================
def validate_env_vars():
    required_vars = ["FABRIC_CLIENT_ID", "FABRIC_CLIENT_SECRET", "FABRIC_TENANT_ID"]
    missing_vars = [var for var in required_vars if not os.getenv(var)]

    if missing_vars:
        print(f"❌ Erro: Variáveis de ambiente ausentes: {', '.join(missing_vars)}")
        sys.exit(1)


# ==========================================================
# 🚀 Função principal de deploy
# ==========================================================
def run_fabric_cli(workspace: str):
    print(f"📦 Iniciando deploy no workspace: {workspace}")

    cmd = [
        "fabric", "deploy",
        "--workspace", workspace,
        "--source", "./src",
        "--spn-client-id", os.getenv("FABRIC_CLIENT_ID"),
        "--spn-client-secret", os.getenv("FABRIC_CLIENT_SECRET"),
        "--spn-tenant-id", os.getenv("FABRIC_TENANT_ID")
    ]

    print("🛠️ Executando comando:")
    print(" ".join(cmd))

    try:
        subprocess.run(cmd, check=True)
        print("✅ Deploy concluído com sucesso!")
    except subprocess.CalledProcessError as e:
        print(f"❌ Erro durante o deploy: {e}")
        sys.exit(1)


# ==========================================================
# 🧭 Ponto de entrada principal
# ==========================================================
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Script de Deploy para Power BI Fabric")
    parser.add_argument(
        "--environment",
        required=True,
        choices=["develop", "staggin", "master"],
        help="Ambiente de deploy: develop, staggin ou master"
    )

    args = parser.parse_args()
    environment = args.environment.lower()

    workspace = WORKSPACE_MAP.get(environment)
    if not workspace:
        print(f"❌ Ambiente inválido: {environment}")
        sys.exit(1)

    validate_env_vars()
    run_fabric_cli(workspace)
