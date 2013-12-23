Exercice de TP de Grammaires Lexicalisées
=========================================

## Sujet

**Sujet 5 :** Définir un analyseur de grammaire catégorielle classique (avec les
deux règles classiques) utilisant une méthode tabulaire (algorithme CYK). Le
programme devra indiquer si une chaîne en entrée est analysable avec la
grammaire et si oui, devra donner au moins une dérivation.

**Travail facultatif :** le programme affichera une ou toutes les dérivations
sous forme graphique.

## Le code et le projet

### Dart

Le projet entier est basé sur le langage Dart et je n'ai utilisé que les fonctionnalités
de base offerte par le langage. Aucune librairie extérieure n'a été utilisées.

### Structure des dossiers

 - **lib :** Contient la library que j'ai créée pour gérer les grammaires catégorielles.
 Le code est commenté et une documentation au format HTML est disponible dans le sous-dossier
 docs.
 - **test :** Contient des tests liés au développement de ma librairie.
 - **example :** Contient les exemples basés sur l'exercice 5.1 de la feuille de
 révision pour le CC.
 - **web :** Contient l'application web permettant de fournir une interface graphique
 minimale pour tester la librairie.
 
### Déroulement du développement
 
 TODO
 
## Installation
 
Le plus simple pour travailler en Dart est d'installer [DartEditor](https://www.dartlang.org/tools/editor/).

Une fois installer, les exemples peuvent être exécuter via clic-droit sur questionX.dart / Run.

L'application web peut être lancée dans Dartium, une version modifiée de Chromium qui intègre une VM Dart. Pour cela, un clic-droit sur index.html dans le répertoire web / Run in Dartium.
Il m'est arrivé de rencontrer des problèmes avec Dartium sur Linux. Vous pouvez donc essayer de lancer la version compilée en JS qui sera ensuite lancé dans votre navigateur par défaut. Pour cela, clic-droit sur index.html / Run as javascript.

Si malgré tout vous n'arrivez pas à faire fonctionner le projet, j'ai hébergé une version fonctionnelle à l'adresse suivante : [http://noemisalaun.fr/grammar](http://noemisalaun.fr/grammar).

Vous pouvez aussi retrouver la doc de la librairie à l'adresse [http://noemisalaun.fr/grammar/doc](http://noemisalaun.fr/grammar/doc)

## Utilisation de l'appli web

 - Les règles de la grammaire doivent être au format "terme: SN/V" avec une règle par ligne. Normalement le parser est assez souple au niveau des espaces et des lignes vides, mais on ne sait jamais.
 - La phrase à dériver est découpé aux espaces.
 - Toutes les dérivations sont retrouvées. Pour chaque étape de la dérivation :
   - En bleu, la partie de gauche
   - En rouge, la partie de droite
   - En fin de ligne, la règle utilisée (/ ou \\)
 - Le cadre de droit correspond à la console de Dart, il permet d'afficher le détail en cas d'erreur.
