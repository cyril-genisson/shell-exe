#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: my_calculator.sh
# Description: une calculatrice rudimentaire
#

if [ $2 = "+" ] ; then
    echo $(($1 + $3))
elif
    [ $2 = "-" ]; then
    echo $(($1 - $3))
elif
    [ $2 = "*" ] ; then
    echo $(($1 * $3))
elif
    [ $2 = "/" ] ; then
    echo $(($1 / $3))
else
    echo "Opérateur inconnu: $2"
    exit 1
fi

exit 0
