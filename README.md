# SHELL.EXE

Commençons par le commencement:
- on commence par créer les répertoires pour les différents JOB:
```bash
mkdir Job{01..09} PourAllerPlusLoin
```

La structure étant faite passons aux JOBS
- Job01: myfirstscript.sh
- Job02: myupdate.sh
- Job03: add.sh
- Job04: argument.sh
- Job05: Hello_bye.sh
- Job06: my_calculator.sh
- Job07: myloop.sh
- Job08: getlogs.sh
- Job09: accessrights.sh
- Pour aller plus loin... : alcasar_login

    Je ne vais pas détailler ici l'ensemble des **Jobs** car ils
sont suffisement explicite dans le PDF. Néanmoins, deux d'entre
eux ont particulièrement attiré mon attention:

le **Job09** avec un fichier cvs on ne peu plus, comment dire,
dégueulasse, oui dégueulasse c'est le mot qui convient. En effet
il n'est pas fournis nettoyé. Bon là je me dis:
1) je le nettoie à la main comme un débile;
2) je fais du code un peu sale mais je fais en sorte que cela passe;
3) je crée une commande awk ou sed pour le traiter 
de toutes les cochonnerie que la secrétaire de l'acceuil a pu mettre
dedans à moins que ce soit un admisnistrateur négligeant, il me semble
que son prénom commence par un T.
    Enfin, quoi qu'il en soit nous devons bien faire quelsque chose. L'option 1
n'est pas une option car je risque de manquer de compétences **Système**
et l'option 2 risque de dévaluer la notation en... ah oui **Soft Skills**.
Ne reste donc que l'option 3 même si je dois bien avouer que ça me fait un
peu suer de rattraper les bêtises des autres.
Bon disons que l'on veuille voir les caractères nons imprimables:
```bash
$ cat -v Shell_Userlist.csv
Id,Prenom,Nom,Mdp,RM-CM-4le^M
1001,Octavia,Blake,U9nh4W,User^M
1002,Bellamy,Blake,2Nn2Ja,Admin^M
1003,Abigail ,Griffin,v8G2Zc,User^M
1004,Finn,Collins,N98rqT,User^M
1005,Jasper,Jordan,8Ltk4R,User^M
1006,Raven,Reyes,n45RQz,Admin^M
1007,Monty ,Green,Y3yzP4,User^M
1008,Clarke,Griffin,f56SxP,Admin^M
1009,Marcus,Jane,bNw4T9,User^M
1010,John ,Murphy,zT5fH2,User^M
1011,Wells,Jaha,z4b5RJ,User^M
1012,Maddy ,Griffin,9jqW9F,Admin
```
Nous voilà donc déjà fixé sur ce point, pas une seule ligne n'échappe
à la dure loi de notre secrétaire. Allez, ne soyons pas vache! tous
les matins elle nous accueille avec son  joli sourire et un hochement
de tête (il y a sûrement un peu de timidité là-dessous). Hmm...

Notre job consiste donc à supprimer tous ces caractères et espaces
inutiles.
```bash
# Pour voir que cela fonctionne
sed 's/[[:cntrl:]]//g' Shell_Userlist.csv | cat -v
Id,Prenom,Nom,Mdp,RM-CM-4le
1001,Octavia,Blake,U9nh4W,User
1002,Bellamy,Blake,2Nn2Ja,Admin
1003,Abigail ,Griffin,v8G2Zc,User
1004,Finn,Collins,N98rqT,User
1005,Jasper,Jordan,8Ltk4R,User
1006,Raven,Reyes,n45RQz,Admin
1007,Monty ,Green,Y3yzP4,User
1008,Clarke,Griffin,f56SxP,Admin
1009,Marcus,Jane,bNw4T9,User
1010,John ,Murphy,zT5fH2,User
1011,Wells,Jaha,z4b5RJ,User
1012,Maddy ,Griffin,9jqW9F,Admin

# Pour modifier le fichier à ma volé
sed -i 's/[[:cntrl:]]//g' Shell_Userlist.csv
```

On utilise le même principe pour suprimer les espaces:
```bash
sed -i 's/[[:space:]]//g' Shell_Userlist.csv | cat -v
Id,Prenom,Nom,Mdp,Rôle
1001,Octavia,Blake,U9nh4W,User
1002,Bellamy,Blake,2Nn2Ja,Admin
1003,Abigail,Griffin,v8G2Zc,User
1004,Finn,Collins,N98rqT,User
1005,Jasper,Jordan,8Ltk4R,User
1006,Raven,Reyes,n45RQz,Admin
1007,Monty,Green,Y3yzP4,User
1008,Clarke,Griffin,f56SxP,Admin
1009,Marcus,Jane,bNw4T9,User
1010,John,Murphy,zT5fH2,User
1011,Wells,Jaha,z4b5RJ,User
1012,Maddy,Griffin,9jqW9F,Admin
1013,Bob,Dylan,Fuck,Admin
```

Pour finir il ne reste qu'à règler le cas où notre belle demoiselle viendrait à
ajouter de nouveaux nom dans cette liste. Nous avons décidé d'utiliser
l'empreinte sha256 du fichier après passage de nos filtres magiques pour savoir si
un nouveau nom apparaît sur la Dream liste. Si l'empreinte change alors cela méritera
un nouveau traitement.
Le reste des choix sont largement expliqués en commentaire dans le script.

Le Job **Pour aller plus loin** mérite à lui seul sa page: [Job Bonus](https://github.com/cyril-genisson/shell-exe/tree/main/PourAllerPlusLoin)
