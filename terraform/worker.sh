#!/bin/bash

# Sistem güncellemeleri
sudo apt-get update -y
sudo apt-get upgrade -y
sudo hostnamectl set-hostname kube-worker

# Gerekli paketlerin kurulumu
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Kubernetes deposunun eklenmesi
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /etc/apt/trusted.gpg.d/kubernetes.asc
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# Docker kurulumu
sudo apt-get install -y docker.io

# Kubernetes paketlerinin kurulumu
sudo apt-get install -y kubelet=1.28.2-00 kubeadm=1.28.2-00 kubectl=1.28.2-00 kubernetes-cni

# Kubernetes paketlerinin güncellenmesini engelleme
sudo apt-mark hold kubelet kubeadm kubectl

# Docker servisini başlat ve etkinleştir
sudo systemctl start docker
sudo systemctl enable docker

# Docker kullanıcısının izinleri
sudo usermod -aG docker ubuntu
newgrp docker

# Kubernetes için kernel ayarları
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Kernel ayarlarının uygulanması
sudo sysctl --system

# Containerd yapılandırmasının yapılması
sudo mkdir /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# Kubernetes imajlarının çekilmesi
sudo kubeadm config images pull

# Master node'a katılmak için gerekli bilgilerin çekilmesi
MASTER_IP="${master-private}"
TOKEN=$(mssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t ${master-id} -r ${region} ubuntu@${master-ip} kubeadm token list | awk 'NR == 2 {print $1}')
CA_CERT_HASH=$(mssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t ${master-id} -r ${region} ubuntu@${master-ip} openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')

# Master node'a katılma işlemi
sudo kubeadm join ${MASTER_IP}:6443 --token ${TOKEN} --discovery-token-ca-cert-hash sha256:${CA_CERT_HASH} --ignore-preflight-errors=All

# Kubernetes node'unun durumunun kontrol edilmesi
sudo kubectl get nodes

# Python3 kurulumu
sudo apt-get install -y python3 python3-pip python3-dev

echo "Kubernetes Worker Node kurulumu ve master node'a bağlanma tamamlandı. Python3 kuruldu."
