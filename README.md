

# kuroagent

Ce repository contient les manifests pour ajouter l'add-in non officiel permettant d'interagir avec votre LLM préféré directement dans **Excel** et **PowerPoint**.

| Add-in | Manifest | Statut |
|--------|----------|--------|
| **Excel** | `manifest.xml` | ✅ Stable |
| **PowerPoint** | `manifest_powerpoint.xml` | ✅ Stable |

## Installation Excel

1. Ouvrez Excel
2. Allez dans **Compléments** → **Autres compléments** (ou **Fichier** → **Options** → **Compléments** → **Gérer : Compléments du navigateur** → **Atteindre**)
3. Ou : **Fichier** → **Compléments** → **Compléments personnalisés** → **Charger mon complément**
4. Sélectionnez le fichier `manifest.xml` de ce repository

Cet add-in est ajouté temporairement à votre Excel.

## Installation PowerPoint

1. Ouvrez PowerPoint
2. Allez dans **Compléments** → **Autres compléments** (ou **Fichier** → **Options** → **Compléments** → **Gérer : Compléments du navigateur** → **Atteindre**)
3. Ou : **Fichier** → **Compléments** → **Compléments personnalisés** → **Charger mon complément**
4. Sélectionnez le fichier `manifest_powerpoint.xml` de ce repository

Cet add-in est ajouté temporairement à votre PowerPoint.

## Prérequis

Vous avez besoin d'une clé API pour l'un des providers suivants :

| Provider | API URL | Lien |
|----------|---------|------|
| **OpenRouter** | `https://openrouter.ai/api/v1/chat/completions` | [openrouter.ai](https://openrouter.ai) |
| **Anthropic (Claude)** | `https://api.anthropic.com/v1/messages` | [console.anthropic.com](https://console.anthropic.com) |
| **Google Gemini** | `https://generativelanguage.googleapis.com/v1beta/openai/chat/completions` | [aistudio.google.com](https://aistudio.google.com) |
| **OpenAI (GPT)** | `https://api.openai.com/v1/chat/completions` | [platform.openai.com](https://platform.openai.com) |

Toutes ces clés sont gratuites pour commencer (crédits d'essai offerts).

### Modèles locaux (gratuit, sans clé API)

Vous pouvez aussi utiliser un LLM en local sur votre machine. Aucune clé API n'est nécessaire.

| Outil | Endpoint par défaut | Lien |
|-------|---------------------|------|
| **Ollama** | `http://localhost:11434/v1/chat/completions` | [ollama.com](https://ollama.com) |
| **LM Studio** | `http://localhost:1234/v1/chat/completions` | [lmstudio.ai](https://lmstudio.ai) |
| **llama.cpp** | `http://localhost:8080/v1/chat/completions` | [github.com/ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp) |
| **vLLM** | `http://localhost:8000/v1/chat/completions` | [docs.vllm.ai](https://docs.vllm.ai) |
| **text-generation-webui** | `http://localhost:5000/v1/chat/completions` | [github.com/oobabooga](https://github.com/oobabooga/text-generation-webui) |

**Comment faire :**
1. Lancez votre serveur LLM local (ex: `ollama serve`)
2. Dans les paramètres de l'add-in, entrez l'endpoint local (ex: `http://localhost:11434/v1/chat/completions`)
3. Laissez le champ API Key vide
4. Entrez le nom du modèle (ex: `llama3`, `mistral`, `qwen2.5`)

> **Note :** Les requêtes vers `localhost` et `127.0.0.1` sont autorisées par la politique de sécurité de l'add-in.

## Comment ça marche

L'add-in s'intègre dans Excel et PowerPoint et permet de faire des requêtes à votre LLM via l'API de votre choix, sans quitter votre application.

- **Excel** : fonctions personnalisées + chat AI pour manipuler vos feuilles de calcul
- **PowerPoint** : chat AI pour créer, modifier et organiser vos présentations (slides, shapes, textes, tableaux, graphiques)

## Configuration

1. Ouvrez l'add-in via le bouton **Open KuroAgent** dans l'onglet Accueil
2. Entrez l'URL de l'API de votre provider
3. Entrez votre clé API (format Bearer)
4. Choisissez le modèle
5. Cliquez sur **Save**

Les paramètres sont sauvegardés localement dans votre navigateur.

## PowerPoint JavaScript API — Fonctionnalités supportées

L'add-in utilise le PowerPoint JavaScript API (Office.js). Voici le support des fonctionnalités :

### Supportées

| Fonctionnalité | Statut | Description |
|---|---|---|
| **Slides** | ✅ Supporté | Ajouter, supprimer, renommer des slides |
| **Texte** | ✅ Supporté | Modifier le texte de n'importe quelle shape |
| **Shapes** | ✅ Supporté | Ajouter/supprimer des shapes (rectangle, ellipse, triangle, ligne, textbox) |
| **Tableaux** | ✅ Supporté | Ajouter des tableaux avec lignes/colonnes personnalisées |
| **Graphiques** | ✅ Supporté | Ajouter des graphiques (column, bar, line, pie, area) |
| **Images** | ✅ Supporté | Ajouter des images via URL |
| **Lecture contexte** | ✅ Supporté | Lire toutes les slides, shapes et textes de la présentation |
| **Chat AI** | ✅ Supporté | Chat avec LLM pour planifier et exécuter des opérations |
| **Mode explication** | ✅ Supporté | Mode lecture seule pour analyser la présentation sans modifier |
| **Snapshot/Revert** | ✅ Supporté | Sauvegarde de l'état avant modification, possibilité de revenir en arrière |
| **Vérification** | ✅ Supporté | Vérification automatique des opérations après exécution |

### Non supportées / Limitations

| Fonctionnalité | Statut | Notes |
|---|---|---|
| **Animations** | ❌ Non supporté | Pas d'accès aux animations de slides |
| **Transitions** | ❌ Non supporté | Pas de contrôle des transitions entre slides |
| **Thèmes/Design** | ❌ Non supporté | Pas de modification des thèmes de présentation |
| **Master Slides** | ❌ Non supporté | Pas d'accès aux slides maîtres |
| **Formules** | ❌ Pas applicable | PowerPoint ne supporte pas les formules |
| **SmartArt** | ❌ Non supporté | Pas de création ou manipulation de SmartArt |

---

Développé par [Yann Assoumou](https://github.com/yannassoumou) — open source sous MIT License.
