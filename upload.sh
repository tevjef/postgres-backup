#!/bin/sh

# export PGHOST
# export PGPORT
# export PGDATABASE
# export PGUSER
# export PGPASSWORD

# export GCS_BUCKET
# export GCS_PROJECT

# export SLEEP_SECONDS

backup(){
    echo "Starting backup..."
    pg_dump -v -w -c | gzip -9 > $PGDATABASE.sql.gz
    FILE_NAME="$PGDATABASE-$(date +"%Y%m%d%H%M")"
    gcsupload -bucket "$GCS_BUCKET" -project "$GCS_PROJECT" -name "$FILE_NAME" -source "$PGDATABASE.sql.gz"
    echo "Backup complete..."
}

if [ -z $SLEEP_SECONDS ]; then
    backup
else
    while true
    do
        backup
        echo "Sleeping for $SLEEP_SECONDS seconds.."
        sleep $SLEEP_SECONDS
    done
fi



