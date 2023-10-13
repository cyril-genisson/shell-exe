#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: myupdate.sh
# Description: met à jour le gestionnaire de paquets
# et les paquets du système. On assume ici le fait
# que le script est exécuté par une tâche cron en mode
# root.
#

apt update &&
apt upgrade -y
exit 0
