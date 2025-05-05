#!/bin/bash

# Criar pasta local para binários, se ainda não existir
mkdir -p $HOME/bin

# Baixar kubectl versão 1.12.10 para EKS
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.10/2019-08-14/bin/linux/amd64/kubectl

# Dar permissão de execução
chmod +x ./kubectl

# Copiar o binário para o diretório $HOME/bin
cp ./kubectl $HOME/bin/kubectl

# Exportar o PATH para incluir $HOME/bin
export PATH=$HOME/bin:$PATH

# Garantir que o PATH esteja atualizado no bash futuramente
echo 'export PATH=$HOME/bin:$PATH' >> ~/.zshrc

# Verificar a instalação
kubectl version --client
