#!/bin/bash
# variables
# shellcheck disable=SC2006
today=`date "+%Y-%m-%d_%H-%M-%S"`
backupfolder="backup_${today}"

# mysql dump & wordpress from remote server to /backups folder
# shellcheck disable=SC2260
mkdir -p ../backups/"${backupfolder}" && mkdir -p ../backups/"${backupfolder}"/wordpress
ssh -i ~/.ssh/arkhayds groupe1@20.115.224.206 mysqldump -u utilisateur -ppassword demo > ../backups/"${backupfolder}"/dump.sql
scp -i ~/.ssh/arkhayds groupe1@20.115.224.206:/var/www/wordpress/index.php ../backups/"${backupfolder}"/wordpress/

# add entry to log file
if [ "$0" ]
then
    echo "added ${backupfolder}" >> ../backups/backups.log
else
    echo 'action if config does not exist'
fi

#for OUTPUT in $(cd ../backups/ && ls | grep "backup*" | grep -v "\.log" | cut -d "_" -f 2-3)
#do
#  if [ date -d "${OUTPUT}" -lt date -d "2023-02-15_16-24-44" ]
#    then
#      echo "${OUTPUT}"
#  fi
#done

## CORRECTION -
# Amélioration scp -> combiner la commande avec un tar -czf pour balancer dans une archive le folder wordpress directement
# Amélioration potentielle ++ -> mettre le dump dans une archive et ajouter le folder WP dans cette même archive ensuite
# notation utile pour glisser le résultat des commandes dans un .log
# if [ mysqldump -u $mysql_user -p $mysql_password $mysql_database > db.sql 2>> $log_file]; then
#    echo "Backup file for the database created at $(date +%Y%m%d_%H%M%S)" >> $log_file
# else
#    echo "ERROR Bakcup file for the database not created at $(date +%Y%m%d_%H%M%S)" >> $log_file
# fi

# on peut ensuite soit placer le script sur un serveur de stockage distant et call directement dans le serveur principal
# ou alors exécuter le script sur le serveur principal et envoyer via scp le fichier vers le serveur de stockage distant