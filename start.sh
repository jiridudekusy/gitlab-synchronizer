#!/bin/bash
echo "Starting Gitlab Synhronizer" | ts 2>&1
cd /repositories;
/bin/synchronize.sh | ts 2>&1
cron
echo "Gitlab Synhronizer started" | ts > /var/log/cron.log 2>&1
tail -f -n 1 /var/log/cron.log
