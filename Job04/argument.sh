#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: argument.sh
# Description: sert à copier le fichier2 dans le fichier1
#
if [ -z $1 ] & [ -z $2 ] ; then
    echo "Utilisattion: $0 NewCopy File"
elif [ -f $2 ] ; then
    cat $2 > $1
    exit 0
else
    echo "$2 doit être un fichier."
    exit 1
fi
