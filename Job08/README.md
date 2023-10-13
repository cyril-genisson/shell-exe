# Mise en garde
Ce script a été conçu pour insérer directement les Logs dans le dossier Github du créateur
du script. Si vous souhaitez tester ce script pour vos propres essais je vous conseille
fortement de changer la variable **$TARGET** pour l'adapter à vos besoins.

Pour la phase de test **j'ai pris la liberté** de régler le crontab à 1 minute et non pas 30 comme
indiqué dans le sujet (attendre 30 minutes entre chaque appel c'est plutôt long...). Néanmoins voici
la démmarche:
- S'asurer que le service syslog est installé, et démarré:
```bash
systemctl enable --now syslog
systemctl status syslog
● rsyslog.service - System Logging Service
     Loaded: loaded (/lib/systemd/system/rsyslog.service; enabled; preset: enabled)
     Active: active (running) since Thu 2023-10-12 11:51:20 CEST; 9h ago
TriggeredBy: ● syslog.socket
       Docs: man:rsyslogd(8)
             man:rsyslog.conf(5)
             https://www.rsyslog.com/doc/
   Main PID: 85058 (rsyslogd)
      Tasks: 4 (limit: 19075)
     Memory: 4.6M
        CPU: 3.682s
     CGroup: /system.slice/rsyslog.service
             └─85058 /usr/sbin/rsyslogd -n -iNONE
```

- S"assurrer que le service cron est opérationnel également
```bash
systemctl enable --now cron
systemctl status cron
● cron.service - Regular background program processing daemon
     Loaded: loaded (/lib/systemd/system/cron.service; enabled; preset: enabled)
     Active: active (running) since Thu 2023-10-12 21:19:59 CEST; 30min ago
       Docs: man:cron(8)
   Main PID: 99360 (cron)
      Tasks: 1 (limit: 19075)
     Memory: 812.0K
        CPU: 3.114s
     CGroup: /system.slice/cron.service
             └─99360 /usr/sbin/cron -f
```

- Enfin éditer le crontab de root pour que la tâche soit excécutée toute les minutes (et oui pas 30 ;p )
```bash
sudo -i
crontab -e
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
*/1 * * * * ~kaman/github/shell-exe/Job08/get_logs.sh kaman
```

Et voilà je pense que tout y est.
