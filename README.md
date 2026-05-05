# kuroagent

Ce repository contient le manifest pour ajouter l'add-in non officiel permettant d'interagir avec votre LLM préféré directement dans **Excel**.

> **Note :** L'add-in PowerPoint est encore en développement et ne fonctionne pas encore. Seul le manifest Excel (`manifest.xml`) est fonctionnel.

## Installation

1. Ouvrez Excel
2. Allez dans **Compléments** → **Autres compléments** (ou **Fichier** → **Options** → **Compléments** → **Gérer : Compléments du navigateur** → **Atteindre**)
3. Ou : **Fichier** → **Compléments** → **Compléments personnalisés** → **Charger mon complément**
4. Sélectionnez le fichier `manifest.xml` de ce repository

Cet add-in est ajouté temporairement à votre Excel.

## Prérequis

Vous avez besoin d'une clé API pour l'un des providers suivants :

| Provider | API URL | Lien |
|----------|---------|------|
| **OpenRouter** | `https://openrouter.ai/api/v1/chat/completions` | [openrouter.ai](https://openrouter.ai) |
| **Anthropic (Claude)** | `https://api.anthropic.com/v1/messages` | [console.anthropic.com](https://console.anthropic.com) |
| **Google Gemini** | `https://generativelanguage.googleapis.com/v1beta/openai/chat/completions` | [aistudio.google.com](https://aistudio.google.com) |
| **OpenAI (GPT)** | `https://api.openai.com/v1/chat/completions` | [platform.openai.com](https://platform.openai.com) |

Toutes ces clés sont gratuites pour commencer (crédits d'essai offerts).

## Comment ça marche

L'add-in ajoute des fonctions personnalisées dans Excel qui permettent de faire des requêtes à votre LLM via l'API de votre choix, sans quitter vos feuilles de calcul.

## Configuration

1. Ouvrez l'add-in via le bouton **KuroAgent** dans l'onglet Accueil
2. Entrez l'URL de l'API de votre provider
3. Entrez votre clé API (format Bearer)
4. Choisissez le modèle
5. Cliquez sur **Save**

Les paramètres sont sauvegardés localement dans votre navigateur.

---

Développé par [Yann Assoumou](https://github.com/yannassoumou) — open source sous MIT License.
