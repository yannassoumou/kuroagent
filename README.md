# kuroagent

Ce repository contient les manifests nécessaires pour ajouter l'add-in non officiel permettant d'interagir avec votre LLM préféré directement dans les feuilles Excel.

## Installation

1. Ouvrez Excel
2. Allez dans **Compléments** → **Autres compléments** (ou **Fichier** → **Options** → **Compléments** → **Gérer : Compléments du navigateur** → **Atteindre**)
3. Ou : **Fichier** → **Compléments** → **Compléments personnalisés** → ** Charger mon complément**
4. Sélectionnez le fichier `manifest.xml` de ce repository

Cet add-in est ajouté temporairement à votre Excel.

## Prérequis

- Une clé API [OpenRouter](https://openrouter.ai) (gratuite pour commencer)
- Pour le moment, seul OpenRouter est supporté. D'autres providers seront ajoutés progressivement.

## Comment ça marche

L'add-in ajoute des fonctions personnalisées dans Excel qui permettent de faire des requêtes à votre LLM via l'API OpenRouter, sans quitter vos feuilles de calcul.
