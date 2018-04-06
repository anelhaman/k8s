# Grant permiss files.
sudo iptables-save > /tmp/iptables.conf
sudo chmod +x initialsetup.sh
./initialsetup.sh
sudo iptables-restore < /tmp/iptables.conf

# As root on masternode
swapoff -a
kubeadm init --kubernetes-version=v1.9.2 --pod-network-cidr=10.244.0.0/16 

##
# Or use initial with token
# kubeadm init --kubernetes-version=v1.9.2 --pod-network-cidr=10.244.0.0/16 --token 8c2350.f55343444a6ffc46
##
# After initial command. System would return joined string then have to keep it saved.
# Like this
# kubeadm join --token <token> <ip>:6443 --discovery-token-ca-cert-hash bla bla
##

# As regular user on masternode
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# taint masternode
kubectl taint nodes --all node-role.kubernetes.io/master-

# flannel net plugin
kubectl apply -f https://raw.githubusercontent.com/anelhaman/k8s/master/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/anelhaman/k8s/master/kube-flannel-rbac.yml

# show pods
kubectl get pods --all-namespaces



# show all node after joined worknode
kubectl get nodes
