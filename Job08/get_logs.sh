#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: get_logs.sh
# Description:  Affiche le nombre de connexions d'un utilisateur
# passé en paramètre et génère un rapport. Ce script assume le
# fait d'être lancé par root.
# 
# Je ne pense pas que du bien du format d'horodatage choisi...
#
SAVE_PWD=$(pwd)
TARGET=/home/kaman/github/shell-exe/Job08

if [ -z $1 ] ; then
    echo "Utilisation: $0 USERNAME"
    exit 1
fi

id $1
if [ $? -eq 0 ] ; then
    cd $TARGET
    DATE=$(date "+%d-%m-%Y-%H:%M")
    FILE=number_connection-$DATE

    if [ ! -d Backup ] ; then
        mkdir Backup
    fi

    COUNT=$(cat /var/log/auth.log | grep $1 | grep "session opened" | wc -l)

    echo "Nombre de connexions de $1: $COUNT" > $FILE
    
    if [ !  -d Backup ] ; then
        mkdir -p /Backup
    fi
    tar -cvf Backup/$FILE.tar $FILE
    cd $SAVE_PWD
    exit 0
else
    exit 1
fi
exit 0
