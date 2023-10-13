#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: myloop.sh
# Description: un script qui ne fait rien 
#

LINE="Je suis un script qui arrive à faire une boucle"

for k in {1..10} ; do
    echo "$LINE $k"
done

exit 0
