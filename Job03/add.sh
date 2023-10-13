#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: add.sh
# Description: comme son nom l'indique ce script sert à
# additionner deux nombres passés en paramètre. 
#
if [ -z $1 ] & [ -z $2 ] ; then
    echo "Utilisation: $0 Nbre1 Nbre2"
    exit 1
fi

echo "Result : $(( $1 + $2 ))"
exit 0
