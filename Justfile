set shell := ["bash", "-c"]
set positional-arguments
export VAULT_ADDR := 'http://127.0.0.1:8200'  
export VAULT_TOKEN := "some-root-token"

default: all
all: version build deploy status test clean
clean-all: clean

[group('default')]
version:
   @echo ">> running $0"

[group('default')]
build: clean
   @echo ">> running $0"
   bash demo_setup.sh

[group('default')]
deploy:
   @echo ">> running $0"
   bash run_app.sh

[group('default')]
status:
   @echo ">> running $0"
   docker container ls

[group('default')]
test:
   @echo ">> running $0"
   docker exec -it learn-vault-secrets-dotnet-vault-db-1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'Testing!123' -d HashiCorp -Q "SELECT * FROM Projects" -C
   export VAULT_ADDR='http://127.0.0.1:8200'  VAULT_TOKEN=some-root-token
   export VAULT_TOKEN=$(vault write --field=token auth/approle/login role_id=projects-api-role secret_id=$(cat ProjectApi/vault-agent/secret-id)); echo $VAULT_TOKEN
   vault kv get projects-api/secrets/static

[group('default')]
clean:
   @echo ">> running $0"
   bash cleanup_vault_agent.sh
   bash cleanup.sh

