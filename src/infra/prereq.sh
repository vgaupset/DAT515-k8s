sudo apt update 
sudo apt upgrade

# docker

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo systemctl enable docker
sudo systemctl start docker


#kube

sudo apt-get install -y apt-transport-https ca-certificates curl vim git

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# disable swap space

sudo swapoff -a

sudo sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab

# install container runtime

sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF 


sudo modprobe overlay 

sudo modprobe br_netfilter 

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


sudo sysctl --system

sudo apt install -y containerd.io 


sudo mkdir -p /etc/containerd

sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml



sudo systemctl restart containerd

sudo systemctl enable containerd

systemctl status containerd

# Initilize control plane

sudo systemctl enable kubelet

sudo kubeadm config images pull --cri-socket /run/containerd/containerd.sock
