#!/usr/bin/env bash

###
# bash check_file_status.sh /xxx/xxx/test.lock
# 检查某个文件的当前时间与文件的创建时间间隔
# 超过4000秒就输出4000
# 否则输出0
###


FILE_PATH=$1

if [ ! -f "${FILE_PATH}" ]; then
    echo 0
    exit
fi

fileCreateTime=`stat -c %Y ${FILE_PATH}`
currentTime=`date +%s`

if [ $[ ${currentTime} - ${fileCreateTime} ] -gt 4000 ];then
    echo 4000
    exit
fi

echo 0