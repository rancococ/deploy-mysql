#!/bin/bash

DATE=`date +%Y%m%d%H%M`                #every minute
DATABASE=szgd                          #database
USERNAME=root                          #username
PASSWORD="root"                        #password
BACKPATH=/back                         #backpath

# backup command
# backup struct --verbose
/usr/bin/mysqldump --host=127.0.0.1 --port=3306 --user=$USERNAME --password=$PASSWORD --single-transaction --flush-logs --set-gtid-purged=off --opt --routines --triggers --no-data $DATABASE | gzip > ${BACKPATH}\/${DATABASE}_struct_${DATE}.sql.gz
# backup data --verbose
/usr/bin/mysqldump --host=127.0.0.1 --port=3306 --user=$USERNAME --password=$PASSWORD --single-transaction --flush-logs --set-gtid-purged=off --opt --no-create-db --no-create-info --skip-triggers $DATABASE | gzip > ${BACKPATH}\/${DATABASE}_data_${DATE}.sql.gz

# just backup the latest 30 days
find ${BACKPATH} -mtime +30 -name "${DATABASE}_*.sql.gz" -exec rm -f {} \;
