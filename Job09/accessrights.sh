#!/bin/bash
#
# Author: Cyril GENISSON
# Created: 10/10/2023
# Updated: 12/10/2023
#
# Nom du script: accessrights.sh
# Description: Crée dles utilisateurs à partir d'un fichier CSV.
# L'auteur assume que les nom utilisateurs FirstName LasteName sont de la forme: flastname
# Il n'est pas très heureux d'avoir des mots de passes en clair dans un fichier cvs. Sans
# doute serait-il mieux d'en générer un de manière aléatoire et de l'envoyer par mail en
# demandant de la changer à la première connexion.
#
# D'autre part, j'assume que si un utilisateur change de Rôle ou bien de mot de passe dans le fichier
# CSV cela ne sera pas modifié. En effet, un mot de passe dans un CSV ne doit au mieux qu'à servir pour
# envoyer un mail à l'utilisateur pour une nouvelle connexion. D'autre part un changement de Rôle (User / Admin)
# ne devrait se vérifier que sur un nouveau script. Donc ce script ne considère que les ajouts de nouveaux utilisateurs!
#
# Ce qui est clair c'est qu'il est très difficile d'adapter un script un système Linux à
# l'autre. Sous Red Hat on a des options et des comportements très différents que ceux 
# obtenus sur Debian... Difficile de savoir pourquoi.
#
#set -x
NEWUSERFILE="Shell_Userlist"  # Path du fichier CSV

# Nettoyage du fichier
sed -i 's/[[:cntrl:]]//g' $NEWUSERFILE.csv
sed -i 's/[[:space:]]//g' $NEWUSERFILE.csv

# Pour les tests. @ utiliser avec UserDel
if [ -f create.txt ] ; then
    rm create.txt
fi

if [ ! -f $NEWUSERFILE.csv ] || [ -z $0 ] ; then
    echo "Rien a faire."
    exit 0
fi

# Evaluation des modifications du fichier csv par comparaison d'empreinte SHA256
# Evidemment on suppose qu'il ne s'agit que d'ajout d'utilisateurs comme précisé plus haut.
# Donc une simple vérification d'empreinte du fichier doit suffir.
sha256sum -c $NEWUSERFILE.sha256
if [ $? -eq 0 ] ; then
    echo "Rien a faire!"
    exit 0
else
    sha256sum $NEWUSERFILE.csv > $NEWUSERFILE.sha256
fi

# Le fichier csv est composé de 5 champs
# Id,Prénom,Nom,Mdp,Role
#

for ENTRY in $(cat $NEWUSERFILE.csv | grep -v ^Id)
do
    FIRSTNAME=$(echo $ENTRY | cut -d, -f2)
	LASTNAME=$(echo $ENTRY | cut -d, -f3)
    PASSWD=$(echo $ENTRY | cut -d, -f4)
	ROLE=$(echo $ENTRY | cut -d, -f5)
	
    echo $FIRSTNAME $LASTNAME $PASSWORD $ROLE

	# Nettoyage des caractères accentués pour la génération du nom d'utilisateur
	NORMFIRST=$(echo $FIRSTNAME | sed 'y/àâçéèëêïîöôùüûÀÇÉÈËÊÏÎÖÔÙÜÛ/aaceeeeiioouuuACEEEEIIOOUUU/')
	NORMLAST=$(echo $LASTNAME | sed 'y/àâçéèëêïîöôùüûÀÇÉÈËÊÏÎÖÔÙÜÛ/aaceeeeiioouuuACEEEEIIOOUUU/')
    
    # Normalisation du nom d'utilisateur    
	FIRSTINITIAL=$(echo $NORMFIRST | cut -c 1 | tr 'A-Z' 'a-z')
	LOWERLASTNAME=$(echo $NORMLAST | tr -d \' | tr 'A-Z' 'a-z')
	ACCTNAME=$FIRSTINITIAL$LOWERLASTNAME
	
    # Pour les tests
    #echo "$ACCTNAME $PASSWD $ROLE: $FIRSTNAME $LASTNAME"
	
    # Tests pour les doublons
	id $ACCTNAME
    if [ $? -eq 0 ]; then
        continue
	else
		# Création du compte et affectation au groupe
		# Décommenter les 3 lignes suivantes pour la création des utilisateurs
		echo "Création de l'utilisateur $ACCTNAME $ROLE"
        useradd -m -c "$FIRSTNAME $LASTNAME" -s /bin/bash $ACCTNAME
        if [ "$ROLE" = "Admin" ] ; then
            echo "L'utilisateur $ACCTNAME est un Administrateur: ajout au groupe sudo"
            usermod -aG sudo $ACCTNAME
        fi
		echo "$ACCTNAME:$PASSWD" | chpasswd
        echo "$ACCTNAME $PASSWD $ROLE" >> create.txt # pour pouvoir nettoyer le système durant les tests et après par la même occasion.
	fi
done
exit 0
