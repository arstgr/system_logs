#!/bin/bash

sudo yum install audit audit-libs -y

sudo mkdir /var/log/audit
sudo chown root:root /var/log/audit && sudo chmod 0700 /var/log/audit

sudo systemctl enable auditd
sudo service auditd start

sudo systemctl status auditd

sudo cp /etc/audit/audit.rules /etc/audit/audit.rules.bkp

#CentOS 7
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/reboot -k reboot    [ -k Filter key ]" | sudo tee -a /etc/audit/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/init -k reboot" | sudo tee -a /etc/audit/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/poweroff -k reboot" | sudo tee -a /etc/audit/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/shutdow -k reboot" | sudo tee -a /etc/audit/audit.rules

sudo cp /etc/audit/rules.d/audit.rules /etc/audit/rules.d/audit.rules.bkp
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/reboot -k reboot    [ -k Filter key ]" | sudo tee -a /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/init -k reboot" | sudo tee -a /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/poweroff -k reboot" | sudo tee -a /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S execve -F path=/sbin/shutdow -k reboot" | sudo tee -a /etc/audit/rules.d/audit.rules


sudo systemctl enable auditd
sudo service auditd restart
sudo service auditd reload
sudo auditctl -l

#When a reboot occurs that you would like to investigate, use the following command:
#ausearch -i -m system_boot,system_shutdown | tail -4 

#will report the 2 most recent shutdowns or boots. If this reports a SYSTEM_SHUTDOWN followed by a SYSTEM_BOOT, all is well; 
#however, if it reports 2 SYSTEM_BOOT lines in a row or only a single SYSTEM_BOOT line, then the system did not shutdown gracefully.
