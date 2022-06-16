#!/system/bin/sh 
watch=`realpath $0`
scripts_dir=`dirname ${watch}`

#step=5 #间隔的秒数，不能大于60  
#i=0
#while ((i < 60)) ; do  
#	i=$i+step
#    ${scripts_dir}/watch.sh watch
#    sleep $step
#done  
${scripts_dir}/watch.sh watch
# echo "[$(date)] \033[1;33mCrond\033[0m: refresh iptables" >> /data/adb/xray/run/service.log
echo "[$(date)] Crond: refresh iptables" >> /data/adb/xray/run/service.log
exit 0
