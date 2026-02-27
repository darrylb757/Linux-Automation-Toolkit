#!/usr/bin/env python3
import argparse
import re
from collections import Counter
from pathlib import Path

DEFAULT_PATTERNS = [
    r"\berror\b",
    r"\bfailed\b",
    r"\bpanic\b",
    r"\bcritical\b",
    r"\bsegfault\b",
]

def iter_lines(path: Path):
    with path.open("r", errors="ignore") as f:
        for line in f:
            yield line.rstrip("\n")

def main():
    p = argparse.ArgumentParser(description="Scan a log file for common error signals.")
    p.add_argument("--file", required=True, help="Path to log file (e.g. /var/log/syslog)")
    p.add_argument("--patterns", nargs="*", default=DEFAULT_PATTERNS, help="Regex patterns to match")
    p.add_argument("--top", type=int, default=10, help="Show top N matching lines by pattern count")
    args = p.parse_args()

    logfile = Path(args.file)
    if not logfile.exists():
        raise SystemExit(f"Log file not found: {logfile}")

    regexes = [re.compile(x, re.IGNORECASE) for x in args.patterns]
    hits = []
    pattern_counts = Counter()

    for line in iter_lines(logfile):
        matched = False
        for rx in regexes:
            if rx.search(line):
                pattern_counts[rx.pattern] += 1
                matched = True
        if matched:
            hits.append(line)

    print(f"Scanned: {logfile}")
    print(f"Matches: {len(hits)}")
    print("\n--- Pattern counts ---")
    for pat, cnt in pattern_counts.most_common():
        print(f"{cnt:>5}  {pat}")

    print("\n--- Sample matching lines ---")
    for line in hits[: args.top]:
        print(line)

if __name__ == "__main__":
    main()