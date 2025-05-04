#!/bin/bash

set -e  # Faz o script parar imediatamente se algum comando falhar

echo "===== Iniciando configuração do ambiente para EKS ====="

# 1. Atualizar pacotes e garantir dependências básicas
echo "Atualizando pacotes e instalando dependências..."
sudo apt update
sudo apt install unzip curl -y

# 2. Verificar se AWS CLI já está instalado
if ! command -v aws &> /dev/null
then
  echo "AWS CLI não encontrado. Instalando AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -o awscliv2.zip
  sudo ./aws/install
else
  echo "AWS CLI já instalado!"
fi

# 3. Mostrar versão do AWS CLI instalada
aws --version

# 4. Configurar AWS CLI
echo "Executando aws configure. Insira suas credenciais:"
aws configure

# 5. Atualizar kubeconfig para o cluster EKS
echo "Atualizando kubeconfig para acessar o cluster EKS..."
aws eks update-kubeconfig --name EKSDeepDive-jrlb-jvavm --region us-east-1

# 6. Verificar configuração do kubectl
echo "Exibindo configuração atual do kubectl:"
kubectl config view

# 7. Testar conexão com o cluster
echo "Listando serviços disponíveis no cluster:"
kubectl get svc

echo "Exibindo informações do cluster:"
kubectl cluster-info

echo "===== Configuração concluída com sucesso! ====="
