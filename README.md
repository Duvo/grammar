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
 
Après avoir regardé du coté de l'algorithme CYK, je me suis dit que ce serait plus amusant d'essayer de creer une librairie et un algorithme personnel de toutes pièces.

J'ai tout d'abord travailler sur les méthodes permettant de parser une règle à partir d'une chaîne. Par exemple, avec la chaîne (SN/S)/V, l'objectif était d'obtenir une structure de la forme [['SN','/','S'],'/','V'], mais encapsulé dans des classes métiers. Dans ma librairie, il s'agit des classes Rule.
J'ai aussi voulu gérer le problème des règles mal-formées : mauvais parenthèsage, caractère invalide, parenthèse inutiles. Par exemple la chaîne (((SN)/V)/SN) va être traduite au final par (SN/V)/SN.

Une fois les méthodes pour créer les règles terminées, j'ai travaillé sur l'application des règles / et \ sur un couple de terme.

Avec ces quelques fonctions, j'ai pu mettre en place mon algorithme.

**L'algorithme :** Mon algorithme travaille en force brute sur le texte à dériver. Pour chaque couple de terme de la phrase, il test si l'une des 2 règles est applicable. Si c'est le cas, une nouvelle étape est généré à partir de la précédente et la recherche est relancé sur cette nouvelle étape. Mais la recherche sur l'étape précédente ne s'arrête pas, afin de pouvoir retourner l'ensemble des dérivations possible. A chaque fois qu'une règle est applicable, une nouvelle dérivation est créée. A chaque fois qu'une dérivation aboutie, c'est-à-dire que l'on obtient un terme unique, la dérivation est envoyé à un flux qui récupère l'ensemble des dérivations.

*Des tests unitaires permettent de valider les différentes briques de mon implémentation.*
 
## Installation
 
Le plus simple pour travailler en Dart est d'installer [DartEditor](https://www.dartlang.org/tools/editor/).

Une fois installer, les exemples peuvent être exécuter via clic-droit sur questionX.dart / Run.

L'application web peut être lancée dans Dartium, une version modifiée de Chromium qui intègre une VM Dart. Pour cela, un clic-droit sur index.html dans le répertoire web / Run in Dartium.
Il m'est arrivé de rencontrer des problèmes avec Dartium sur Linux. Vous pouvez donc essayer de lancer la version compilée en JS qui sera ensuite lancé dans votre navigateur par défaut. Pour cela, clic-droit sur index.html / Run as javascript.

Si malgré tout vous n'arrivez pas à faire fonctionner le projet, j'ai hébergé une version fonctionnelle à l'adresse suivante : [http://noemisalaun.fr/grammar](http://noemisalaun.fr/grammar).

Vous pouvez aussi retrouver la doc de la librairie à l'adresse [http://noemisalaun.fr/grammar/doc](http://noemisalaun.fr/grammar/doc)

## Utilisation de l'application web

 - Les règles de la grammaire doivent être au format "terme: SN/V" avec une règle par ligne. Normalement le parser est assez souple au niveau des espaces et des lignes vides, mais on ne sait jamais.
 - La phrase à dériver est découpé aux espaces.
 - Toutes les dérivations sont retrouvées. Pour chaque étape de la dérivation :
   - En bleu, la partie de gauche
   - En rouge, la partie de droite
   - En fin de ligne, la règle utilisée (/ ou \\)
 - Le cadre de droit correspond à la console de Dart, il permet d'afficher le détail en cas d'erreur.

### Jeux d'essais

```
Pierre: SN
aime: (SN\S)/SN
beaucoup: (SN\S)\(SN\S)
les: SN/N
cacahouètes: N
```
 - Pierre aime les cacahouètes


```
Pierre: SN
aime: (SN\S)/SN
beaucoup: ((SN\S)/SN)\((SN\S)/SN)
les: SN/N
cacahouètes: N
```
 - Pierre aime beaucoup les cacahouètes
 - Pierre aime beaucoup beaucoup les cacahouètes

```
Pierre: SN
regarde: (SN\S)/SN
donne: ((SN\S)/GP)/SN
une: SN/N
pomme: N
et: (SN\SN)/SN
poire: N
à: GP/SN
Marie: SN
```
 - Pierre regarde Marie
 - Pierre donne une pomme et une poire à Marie
