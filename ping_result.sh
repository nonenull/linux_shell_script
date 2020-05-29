#!/bin/bash

HOST_LIST="8.8.8.8 www.baidu.com"
PACKAGE_NUM=1
current_time=$(date '+%Y-%m-%d %H:%M:%S')
for host in ${HOST_LIST}
do
    ping_result=$(ping -W 1 -c ${PACKAGE_NUM} ${host} | tail -n 2)
    echo -e "${current_time} ==> ${host}\n${ping_result}\n" >> /tmp/ping_result
done
