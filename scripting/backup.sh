# variables
# shellcheck disable=SC2006
today=`date "+%Y-%m-%d_%H-%M-%S"`
backupfolder="backup_${today}"

# mysql dump & wordpress from remote server to /backups folder
# shellcheck disable=SC2260
#mkdir -p ../backups/"${backupfolder}" && mkdir -p ../backups/"${backupfolder}"/wordpress
#ssh -i ~/.ssh/arkhayds groupe1@20.115.224.206 mysqldump -u utilisateur -ppassword demo > ../backups/"${backupfolder}"/dump.sql
#scp -i ~/.ssh/arkhayds groupe1@20.115.224.206:/var/www/wordpress/index.php ../backups/"${backupfolder}"/wordpress/
#
## add entry to log file
#if [ "$0" ]
#then
#    echo "added ${backupfolder}" >> ../backups/backups.log
#else
#    echo 'action if config does not exist'
#fi

for OUTPUT in $(cd ../backups/ && ls | grep "backup*" | grep -v "\.log" | cut -d "_" -f 2-3)
do
  if [ date -d "${OUTPUT}" -lt date -d "2023-02-15_16-24-44" ]
    then
      echo "${OUTPUT}"
  fi
done
