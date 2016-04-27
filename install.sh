systemctl disable firewalld
yum -y update
yum clean all
yum -y install etcd
yum -y install kubernetes
yum -y install ntp
systemctl enable ntpd
yum -y install etcd
sed -i 's/.*ETCD_NAME.*/ETCD_NAME=default/' /etc/etcd/etcd.conf
sed -i 's/.*ETCD_DATA_DIR.*/ETCD_DATA_DIR="\/var\/lib\/etcd\/default.etcd"/' /etc/etcd/etcd.conf
sed -i 's/.*ETCD_LISTEN_CLIENT_URLS.*/ETCD_LISTEN_CLIENT_URLS="http:\/\/0.0.0.0:2379"/' /etc/etcd/etcd.conf
sed -i 's/.*ETCD_ADVERTISE_CLIENT_URLS.*/ETCD_ADVERTISE_CLIENT_URLS="http:\/\/127.0.0.1:2379"/' /etc/etcd/etcd.conf
sed -i 's/.*KUBE_API_ADDRESS.*/KUBE_API_ADDRESS="--address=0.0.0.0"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBE_API_PORT.*/KUBE_API_PORT="--port=8080"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBELET_PORT.*/KUBELET_PORT="--kubelet_port=10250"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBE_ETCD_SERVER.*/KUBE_ETCD_SERVERS="--etcd_servers=http:\/\/127.0.0.1:2379"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBE_SERVICE_ADDRESSES.*/KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0\/16"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBE_ADMISSION_CONTROL.*/KUBE_ADMISSION_CONTROL="--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityCon    textDeny,ResourceQuota"/' /etc/kubernetes/apiserver
sed -i 's/.*KUBE_API_ARGS.*/KUBE_API_ARGS=""/' /etc/kubernetes/apiserver
yum -y install flannel
echo 'FLANNEL_ETCD="http://127.0.0.1:2379"' >> /etc/sysconfig/flanneld
sed -i 's/.*KUBE_MASTER.*/KUBE_MASTER="--master=http:\/\/127.0.0.1:8080"/' /etc/kubernetes/config
sed -i 's/.*KUBELET_ADDRESS.*/KUBELET_ADDRESS="--address=0.0.0.0"/' /etc/kubernetes/kubelet
sed -i 's/.*KUBELET_PORT.*/KUBELET_PORT="--port=10250"/' /etc/kubernetes/kubelet
sed -i 's/.*KUBELET_HOSTNAME.*/KUBELET_HOSTNAME="--hostname_override=127.0.0.1"/' /etc/kubernetes/kubelet
sed -i 's/.*KUBELET_API_SERVER.*/KUBELET_API_SERVER="--api_servers=http:\/\/127.0.0.1:8080"/' /etc/kubernetes/kubelet
sed -i 's/.*KUBELET_ARGS.*/KUBELET_ARGS="--config=\/etc\/kubernetes\/manifests"/' /etc/kubernetes/kubelet
