#!/usr/bin/env bash
set -euo pipefail

# Services wanted to keep healthy (can edit this list)
SERVICES=("ssh" "cron")

LOG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../logs" && pwd)"
OUT="$LOG_DIR/autorestart_$(date +%F).log"
mkdir -p "$LOG_DIR"

echo "==== Auto-restart: $(date -Is) ====" | tee -a "$OUT"

if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not available on this system." | tee -a "$OUT"
  exit 0
fi

for svc in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$svc"; then
    echo "[OK] $svc is active" | tee -a "$OUT"
  else
    echo "[WARN] $svc is NOT active. Attempting restart..." | tee -a "$OUT"
    systemctl restart "$svc" || true

    if systemctl is-active --quiet "$svc"; then
      echo "[FIXED] $svc restarted successfully" | tee -a "$OUT"
    else
      echo "[FAILED] $svc did not restart" | tee -a "$OUT"
    fi
  fi
done

echo "==== Done ====" | tee -a "$OUT"