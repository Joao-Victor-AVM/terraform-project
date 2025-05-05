#!/bin/bash

# Criar pasta local para binários, se ainda não existir
mkdir -p $HOME/bin

# Baixar o aws-iam-authenticator versão 1.10.3
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator

# Dar permissão de execução
chmod +x ./aws-iam-authenticator

# Copiar o binário para o diretório $HOME/bin
cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator

# Exportar o PATH para incluir $HOME/bin
export PATH=$HOME/bin:$PATH

# Garantir que o PATH esteja atualizado no bash futuramente
echo 'export PATH=$HOME/bin:$PATH' >> ~/.zshrc

# Testar a instalação
aws-iam-authenticator help
