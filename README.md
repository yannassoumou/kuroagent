# KuroAgent — AI in Excel

> Interagissez avec n'importe quel LLM directement depuis vos feuilles Excel. Sans quitter votre spreadsheet.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Excel](https://img.shields.io/badge/Excel-2013%2B-217346?logo=microsoftexcel&logoColor=white)](https://www.office.com)
[![Type: Task Pane Add-in](https://img.shields.io/badge/Type-TaskPane%20%2B%20CustomFunctions-blue)](https://learn.microsoft.com/office/dev/add-ins/)

---

## 🚀 Fonctionnalités

- **Chat avec votre LLM préféré** — Claude, GPT-4, Gemini, ou n'importe quel modèle compatible OpenAI
- **Fonctions Excel personnalisées** — appelez l'IA directement depuis une cellule : `=KUROAGENT("analyse ces données")`
- **4 providers supportés** — OpenRouter, Anthropic, Google Gemini, OpenAI
- **100% local** — votre clé API reste sur votre machine, rien n'est stocké sur un serveur tiers
- **Open source** — manifest librement utilisable et modifiable

## ⚡ Installation en 30 secondes

### Excel Desktop (Windows / Mac)

1. Téléchargez [`manifest.xml`](manifest.xml)
2. Ouvrez Excel → **Accueil** → **Compléments** → **Autres compléments**
3. Cliquez sur **☰** (en bas) → **Compléments personnalisés** → **Charger mon complément**
4. Sélectionnez `manifest.xml`
5. Le bouton **KuroAgent** apparaît dans le ruban ✅

### Excel sur le Web

1. Ouvrez [excel.office.com](https://excel.office.com)
2. Même procédure : **Compléments** → **Autres compléments** → **Charger mon complément**
3. Sélectionnez `manifest.xml`

> 💡 Le manifest pointe vers l'hébergement Vercel. Aucune installation serveur nécessaire.

## 🔑 Prérequis

Une clé API gratuite pour l'un de ces providers :

| Provider | Modèle recommandé | Lien |
|----------|------------------|------|
| **OpenRouter** | `meta-llama/llama-3.3-70b-instruct` | [openrouter.ai](https://openrouter.ai) |
| **Anthropic** | `claude-sonnet-4-20250514` | [console.anthropic.com](https://console.anthropic.com) |
| **Google Gemini** | `gemini-2.0-flash` | [aistudio.google.com](https://aistudio.google.com) |
| **OpenAI** | `gpt-4o` | [platform.openai.com](https://platform.openai.com) |

> Toutes les clés offrent des crédits gratuits au démarrage.

## 📖 Utilisation

### 1. Configurer l'add-in

Cliquez sur le bouton **KuroAgent** dans le ruban → configurez votre provider, clé API et modèle → **Save**.

Les paramètres sont sauvegardés localement (localStorage).

### 2. Poser une question

Ouvrez le panneau KuroAgent et discutez avec votre LLM comme dans un chat classique.

### 3. Utiliser les fonctions personnalisées

Dans n'importe quelle cellule Excel :

```
=KUROAGENT("Résume les tendances de vente de ce tableau")
=KUROAGENT("Traduis ce texte en anglais", "fr→en")
=KUROAGENT("Formule Excel pour calculer la croissance mensuelle")
```

## 🏗️ Architecture

```
┌─────────────────────────────────────────────┐
│              Excel (Desktop / Web)           │
│  ┌─────────────┐  ┌──────────────────────┐  │
│  │  Task Pane   │  │  Custom Functions    │  │
│  │  (Chat UI)   │  │  =KUROAGENT(...)     │  │
│  └──────┬──────┘  └──────────┬───────────┘  │
│         │                    │               │
│         └────────┬───────────┘               │
│                  ▼                           │
│         Vercel Hosting                       │
│         (static assets + HTML)               │
└─────────────────────────────────────────────┘
                  │
                  ▼
         ┌────────────────┐
         │  Your API Key  │
         │  Provider API  │
         └────────────────┘
```

- **Code source** : [github.com/yannassoumou/excel](https://github.com/yannassoumou/excel) *(repo privé)*
- **Manifest** : ce repository *(public, MIT)*
- **Hébergement** : [Vercel](https://vercel.com)

## 📄 Licence

Ce manifest est sous licence **MIT**. Vous pouvez l'utiliser, le modifier et le distribuer librement.

Le code source de l'add-in (functions, task pane) reste propriété de l'auteur.

---

Développé par [Yann Assoumou](https://github.com/yannassoumou) — Data Analyst & IA
