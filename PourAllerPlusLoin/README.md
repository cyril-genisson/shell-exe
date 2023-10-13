# Les éléments de recherche
Analyse des en-tête sur le portail de connexion

## Détermination de l'url à contacter
En analysant les connexions réseaux du navigateur j'ai pu déterminer
une page intéressante:
```html
https://alcasar.laplateforme.io:3991/prelogin
```
Cette page nous fournit le challenge par la méthode GET
- https://alcasar.laplateforme.io:3991/prelogin
https://alcasar.laplateforme.io/intercept.php?
res=notyet
uamip=10.10.0.1
uamport=3990
challenge=3ce6a8fb97e4063789e0038fa63929df
called=XX-XX-XX-XX-XX
mac=XX-XX-XX-XX-XX-XX
ip=10.10.10.90
nasid=alcasar.laplateforme.io
sessionid=1697028111000001d3
ssl=https%3a%2f%2f1.0.0.1%3a3991%2f
userurl=http%3a%2f%2fneverssl.com%2f
md=C550E998697290048498E945AD544C09

Un cookie avec un paramètre authtoken nous est fourni. Il semble être nécessaire pour le retour
d'information avec la méthode POST. Pour l'instant nous n'avons pas
pu le récupérer avec l'option -c de cURL (le résultat est un fichier vide). C'est en cours de recherche...

Je pense que cela vient du fait que cURL ne garde pas les historiques de cookies. Pour les concerver il faut
utiliser la lecture et l'écriture du cookie en même temps
```bash
curl -b cookie -c cookie https://www.google.fr
```

## Analyse de la réponse à fournir
Par la méthode POST:
Champ de données à transmettre par la méthode PUT
```txt
$CHALLENGE&userurl=http://neverssl.com/&username=$EMAIL&password=$PASSWD&button=Authentification
```
En analysant la requête POST du navigateur on peut constater que le champ de donné doit être encodé
en url. Pour cela on utilise l'option --data-urlencode de cURL pour qu'il fasse se travail laborieux à
notre place. S'il n'en avait disposé, on aurait écrit un petit script permettant de convertir chaque
caractère en valeur hexadécimale de la table ASCII avec le % qui va bien devant.

Sans le authtoken le serveur ne comprend pas la réponse que je lui envoie ou alors je ne sais pas
formuler la réponse comme il l'attend.

**J'espère que celui qui a eu la bonne idée de faire ce Job Bonus se rend bien compte que si je valide
ce projet et si j'installe un petit module Arduino autonome et bien caché je vais pouvoir être logué
sur le système durant 35h/semaine en ne faisant pas mon quota horaire hebdomadaire... Le SESAME!!!**

** JE PLAISANTE EVIDEMENT!!! **

