#!/usr/bin/env bash
set -euo pipefail

./bin/healthcheck.sh
./bin/autorestart.sh

# Try common log locations
if [[ -f /var/log/syslog ]]; then
  ./.venv/bin/python python/logscan.py --file /var/log/syslog --top 10 || true
elif [[ -f /var/log/messages ]]; then
  ./.venv/bin/python python/logscan.py --file /var/log/messages --top 10 || true
else
  echo "No syslog/messages file found to scan."
fi
