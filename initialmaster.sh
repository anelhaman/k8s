# Grant permiss files.
sudo iptables-save > /tmp/iptables.conf
sudo chmod +x initialsetup.sh
./initialsetup.sh
sudo iptables-restore < /tmp/iptables.conf

# As root on masternode
swapoff -a
kubeadm init --kubernetes-version=v1.9.2 --pod-network-cidr=10.244.0.0/16 --token 8c2350.f55343444a6ffc46

# As regular user on masternode
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/master-
