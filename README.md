*Linux Automation Toolkit

A lightweight Linux operations automation toolkit built with Bash and Python.

This project demonstrates system monitoring, log analysis, automated service remediation, and scheduled execution using cron — simulating real-world DevOps and SRE operational workflows.

*Overview

The Linux Automation Toolkit provides:

- System health monitoring (CPU, memory, disk, uptime)

- Automatic service health checks and restarts

- Log scanning for error patterns

- Centralized logging

- Scheduled execution via cron

This project is designed to simulate basic self-healing infrastructure behavior and operational automation practices used in production environments.

*Project Structure:

linux-automation-toolkit/
│

├── bin/

│   ├── healthcheck.sh

│   ├── autorestart.sh

│   └── run_all.sh
│
├── python/

│   └── logscan.py
│

├── logs/
│

├── .venv/

└── README.md

What This Project Demonstrates

*This toolkit showcases:

- Linux system administration

- Bash scripting

- Python automation

- Log parsing and analysis

- systemd service management

- Cron scheduling

- Basic auto-remediation patterns

*Requirements:

- Linux (Ubuntu, Debian, RHEL, CentOS)

- Bash

- Python 3.8+

- systemd-based system

- cron service running

*Setup Instructions:
1. Clone Repository
git clone https://github.com/yourusername/linux-automation-toolkit.git
cd linux-automation-toolkit

2. Create Python Virtual Environment
python3 -m venv .venv
source .venv/bin/activate

3. Make Scripts Executable
chmod +x bin/*.sh
chmod +x python/logscan.py
Usage
Run Full Toolkit
./bin/run_all.sh

This will:

- Perform system health check

- Verify critical services

- Restart inactive services

- Scan logs for error signals

- Output results to the logs/ directory

- Scheduling via Cron

To automate execution daily at 9 AM:

crontab -e

Add:

0 9 * * * /bin/bash -lc 'cd $HOME/linux-automation-toolkit && source .venv/bin/activate && ./bin/run_all.sh >> logs/cron_$(date +\%F).log 2>&1'

This ensures:

Correct environment loading, Virtual environment activation, 
Output and error logging, Daily execution without manual intervention,
Key Components, healthcheck.sh, Collects CPU, memory, disk usage, 
Displays uptime and load, Retrieves recent warning logs, 
Writes output to timestamped log file, autorestart.sh, 
Checks specified systemd services, Attempts restart if inactive, 
Logs remediation attempts

 Service list can be modified inside the script:

SERVICES=("ssh" "cron")
logscan.py

Scans system logs

Searches for patterns such as:

error, failed, panic, critical, Outputs frequency summary, 
Displays sample matching lines

Example usage:

sudo ./.venv/bin/python python/logscan.py --file /var/log/syslog --top 15
Logging

All logs are stored in:

- logs/

- Logs are timestamped for traceability and auditing.

- Why This Project Was Built

This project was built to:

- Demonstrate Linux operational automation

- Simulate basic monitoring and remediation workflows

- Practice scripting and system troubleshooting

- Reinforce DevOps and SRE principles

- Showcase infrastructure reliability thinking

It reflects real-world responsibilities such as:

- Monitoring system health

- Automating routine checks

- Implementing self-healing mechanisms

- Reducing manual operational overhead

- Future Enhancements

*Possible improvements:

Email or Slack notifications, 
JSON output formatting, 
Integration with Jenkins pipeline, 
Docker containerization, 
Unit tests for Python log scanner, 
systemd timer replacement for cron, 
Ansible deployment playbook