#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../logs" && pwd)"
OUT="$LOG_DIR/healthcheck_$(date +%F).log"

mkdir -p "$LOG_DIR"

echo "==== Health Check: $(date -Is) ====" | tee -a "$OUT"
echo "--- Host ---" | tee -a "$OUT"
hostnamectl 2>/dev/null | tee -a "$OUT" || hostname | tee -a "$OUT"

echo "--- Uptime/Load ---" | tee -a "$OUT"
uptime | tee -a "$OUT"

echo "--- CPU/Memory ---" | tee -a "$OUT"
free -h | tee -a "$OUT"

echo "--- Disk (top) ---" | tee -a "$OUT"
df -h | sort -k5 -hr | head -n 10 | tee -a "$OUT"

echo "--- Recent critical logs (journal) ---" | tee -a "$OUT"
if command -v journalctl >/dev/null 2>&1; then
  journalctl -p warning -n 20 --no-pager | tee -a "$OUT"
else
  echo "journalctl not found." | tee -a "$OUT"
fi

echo "==== Done ====" | tee -a "$OUT"