#!/usr/bin/expect
##此脚本用来自动登录jumpserver

set timeout 10

set USER ""
set PORT ""
set HOST ""
set MFA_SECRET ""

set MFA [ exec python3 {~/jumpserver/mfa.py} $MFA_SECRET ]

spawn ssh -p $PORT $USER@$HOST
expect {
"*yes/no*" { send "yes\n"; exp_continue }
"**OTP*" { send "$MFA\n" }
}
interact
