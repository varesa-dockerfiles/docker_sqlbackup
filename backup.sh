#!/bin/bash

date=$(date +%Y_%m_%d)

if [ -f /root/.ssh/id_rsa ]
then
	echo "Creating backups for $date"
	mkdir $date
	mysql -u$DB_USER -p$DB_PASSWORD -e 'show databases' | while read dbname
	do
		echo "Dumping database $dbname"
		mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$dbname" > "$date/$dbname".sql
	done
	echo "Copying backups to $TARGET"
	rsync -va $date $TARGET
	echo "Done, cleaning up"
	rm -rf ./$date
else
	echo "Please create SSH keys and copy them to the backup target"
	ssh-keygen
	ssh-copy-id $TARGET
fi
