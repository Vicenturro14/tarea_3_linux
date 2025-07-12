#!/bin/bash

# Cron config 
# 0 0,12 * * *
backup_dir="/tmp/mariadb"
db_user="root"
db_password="root"

if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

available_space_GB=$(df -BG --output=avail "$backup_dir" | awk 'NR==2 {print $1}')
if [ "$available_space_GB" -lt 1 ]; then
    echo "Error: Not enough space in $backup_dir to create backup." >&2
    exit 1
fi

TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
docker exec mysql mariadb-dump --user=$db_user --password=$db_password --lock-tables --all-databases > "$backup_dir/backup-$TIMESTAMP.sql"
docker exec mysql tar -czf "$backup_dir/backup-$TIMESTAMP.tar.gz" "$backup_dir/backup-$TIMESTAMP.sql"
docker exec mysql rm "$backup_dir/backup-$TIMESTAMP.sql"
