# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

set shell := ["bash", "-c"]
set positional-arguments

default: all
all: version build deploy status test clean
clean-all: clean

[group('default')]
version:
   @echo ">> running $0"
   docker version
   dotnet --info

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
   open https://localhost:5001/api/Projects &

[group('default')]
clean:
   @echo ">> running $0"
   rm ProjectAPI/bin ProjectAPI/obj ProjectAPI.Test/bin ProjectAPI.Test/obj || true
   docker stop $(docker ps -f name=vault -q)docker network rm learn-dotnet-vault_vpcbr || true
