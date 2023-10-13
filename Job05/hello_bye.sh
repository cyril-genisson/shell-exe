#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: hello_bye.sh
# Description: encore un script inutile
#

if [ $1 = "Hello" ] ; then
    echo "Bonjour, je suis un script !"
elif [ $1 = "Bye" ] ; then
    echo "Au revoir et bonne journée!"
fi
exit 0
