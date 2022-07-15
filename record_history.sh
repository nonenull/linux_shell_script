#!/usr/bin/env bash
# record your system command history to file
# author by nonenull@github.com
# cp this file to /etc/profile.d/, and exec source /etc/profile
CurrentTime=$(date '+%Y%m%d%H%M%S')
HistoryPath="/tmp/history"
CurrentUser=$LOGNAME
UserHistoryPath=${HistoryPath}/${CurrentUser}

userIp=$(who -u am i 2>/dev/null | awk '{print $NF}' | sed -e 's/[()]//g')
if [ "${userIp}" == "" ];then
    userIp="localhost"
fi

if [ ! -d ${HistoryPath} ];then
    mkdir ${HistoryPath}
    chown root.root ${HistoryPath}
    chmod 777 ${HistoryPath}
    chattr +a ${HistoryPath}
fi

if [ ! -d ${UserHistoryPath} ];then
    mkdir -p ${UserHistoryPath}
fi

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=-1
export HISTCONTROL=ignoredups
export HISTFILE="${UserHistoryPath}/${userIp}_${CurrentTime}"
export PROMPT_COMMAND="history -a"

# append to history, don't overwrite it
shopt -s histappend

#chmod 600 ${UserHistoryPath}/ 2>/dev/null
