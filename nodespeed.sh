#!/bin/bash
echo
echo "-----------------------"
echo "VPS一键速度测试服务"
echo
echo "Modified by Moecola.com"
echo "-----------------------"

function pre(){
echo "正在安装。。。"
echo
mkdir -p /speedtest/file && cd /speedtest && wget "https://caddyserver.com/download/linux/386?license=personal&telemetry=on" -O caddy.tar.gz && tar -zxvf caddy.tar.gz && chmod +x caddy && wget https://github.com/adolfintel/speedtest/releases/download/v0.2/NodeSpeedtest-linux && chmod +x NodeSpeedtest-linux && dd if=/dev/zero of=./file/100MB.iso bs=1M count=0 seek=100 && dd if=/dev/zero of=./file/1GB.iso bs=1M count=0 seek=1024
echo "安装完成！"
}

function run(){
read -p "请输入Caddy FileManager使用的端口："  port
echo
echo "NodeSpeedtest-linux v0.2目前只能监听8888端口(后续版本或许能更改)"
nohup /speedtest/caddy -port $port -root /speedtest/file browse &
nohup /speedtest/NodeSpeedtest-linux &
ip=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/'`
echo "Caddy FileManager访问地址：$ip:$port"
echo "NodeSpeedTest测速页访问地址：$ip:8888"
echo "如果无法访问，请在防火墙放行端口$port、8888"
echo "启动完成！"
}

function killit(){
pkill caddy
pid=`ps -ef|grep eedtest|awk -F ' ' '{print $2}'`
kill $pid
echo "关闭完成！"
}

function remove(){
cd
rm -rf /speedtest
echo "卸载完成！"
}

function main(){
echo
echo "1、安装测速服务"
echo "2、启动测速服务"
echo "3、关闭测速服务"
echo "4、卸载测速服务"
echo "5、退出脚本"
read -p "请输入选项：" choice
case $choice in 
1)pre
main
;;
2)run
main
;;
3)killit
main
;;
4)remove
main
;;
5)exit
;;
*)
clear
echo "输入错误！请重新输入"
main
;;
esac
}

main
