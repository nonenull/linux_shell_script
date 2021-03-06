#!/usr/bin/env bash
sudo -i

yum remove -y docker-*
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker && systemctl restart docker
curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

docker -v 
docker-compose -v

cat > /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": [
        "https://1nj0zren.mirror.aliyuncs.com",
        "https://docker.mirrors.ustc.edu.cn",
        "http://f1361db2.m.daocloud.io",
        "https://registry.docker-cn.com"
    ],    "metrics-addr":"0.0.0.0:9323",
    "experimental": true,
    "log-opts":{
        "max-size":"50m",
        "max-file":"3"
    }
}
EOF

systemctl restart docker
curl -L https://raw.githubusercontent.com/docker/compose/1.8.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
