#!/bin/bash
# 每小时跑一次, 需要手动添加 crontab
# crontab:  00 */1 * * * 


# 需要ping的域名, 此处按照需求更改, 多个用空格分开
HOST_LIST="8.8.8.8 www.baidu.com"
# 需要ping的包数量
PACKAGE_NUM=200

current_time=$(date '+%Y-%m-%d %H:%M:%S')

start_ping(){
    host=$1
    ping_result=$(ping -W 1 -c ${PACKAGE_NUM} ${host} | tail -n 2)
    echo "${current_time}\n${ping_result}\n" >> /tmp/ping_result_${host}
    #echo "${current_time}\n${ping_result}\n"
}

for host in ${HOST_LIST}
do
    echo "start ping ${host}"
    start_ping ${host} &
done
