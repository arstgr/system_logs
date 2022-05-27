# System Logs
Scripts for enabling system monitoring logs in Linux

## Tracking system reboots

To track system reboots, there are various options, of which auditd logs and journalctl logs are the most useful. A description of these monitoring tools can be found [here](https://geekflare.com/check-linux-reboot-reason/).

### Auditd
To enable auditd logs on CentOS 7 and configure it to monitor for shutdown and reboot events, run
```
./auditd_rules.sh
```


