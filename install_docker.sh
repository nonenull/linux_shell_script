#/bin/bash
sudo -i

yum remove -y docker-*
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker && systemctl restart docker
curl -L https://github.com/docker/compose/releases/downloads/1.24.0/docker-compose-`uname -S`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

docker -v 
docker-compose -v

cat > /etc/docker/deamon.json <<EOF
{
    "registry-mirror":"https://no1pfk8z.mirror.aliyuncs.com",
    "metrics-addr":"0.0.0.0:9323",
    "experimental": true,
    "log-opts":{
        "max-size":"50m",
        "max-file": 3
    }
}
EOF
