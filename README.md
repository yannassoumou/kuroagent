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

L'add-in ajoute des fonctions personnalisées dans Excel qui permettent de faire des requêtes à votre LLM via l'API de votre choix, sans quitter vos feuilles de calcul.

## Configuration

1. Ouvrez l'add-in via le bouton **KuroAgent** dans l'onglet Accueil
2. Entrez l'URL de l'API de votre provider
3. Entrez votre clé API (format Bearer)
4. Choisissez le modèle
5. Cliquez sur **Save**

Les paramètres sont sauvegardés localement dans votre navigateur.

## Excel JavaScript API — Fonctionnalités supportées

L'add-in utilise l'Excel JavaScript API (Office.js). Voici le support des fonctionnalités :

### Supportées

| Fonctionnalité | Statut | Classes principales |
|---|---|---|
| **PivotTables** | ✅ Supporté | `PivotTable`, `PivotHierarchy`, `PivotField`, `PivotItem`, `PivotLayout`, `PivotFilter` |
| **Graphiques (Charts)** | ✅ Supporté | `Chart`, `ChartSeries`, `ChartAxis`, `ChartDataLabel`, `ChartTrendline` |
| **Tableaux** | ✅ Supporté | `Table`, `TableColumn`, `TableRow`, `TableSort`, `AutoFilter`, `Filter` |
| **Cellules / Ranges** | ✅ Supporté (core) | `Range`, `RangeAreas`, `RangeFormat`, `RangeFont`, `RangeFill`, `RangeBorder` |
| **Feuilles (Worksheets)** | ✅ Supporté | `Worksheet`, `WorksheetCollection`, `WorksheetProtection`, `PageLayout` |
| **Classeurs (Workbooks)** | ✅ Supporté | `Workbook`, `Application`, `NamedItem`, `Setting`, `CustomProperty` |
| **Formatage** | ✅ Supporté | `RangeFormat`, `RangeFont`, `RangeFill`, `RangeBorder`, `Style` |
| **Formatage conditionnel** | ✅ Supporté | `ConditionalFormat`, `ColorScaleConditionalFormat`, `DataBarConditionalFormat`, `IconSetConditionalFormat` |
| **Formes (Shapes)** | ✅ Supporté | `Shape`, `GeometricShape`, `Image`, `Line`, `ShapeGroup`, `TextFrame` |
| **Validation de données** | ✅ Supporté | `DataValidation`, `DataValidationRule`, `BasicDataValidation`, `DateTimeDataValidation` |
| **Segments (Slicers)** | ✅ Supporté | `Slicer`, `SlicerItem`, `SlicerStyle` |
| **Commentaires / Notes** | ✅ Supporté | `Comment`, `CommentReply`, `Note` |
| **Fonctions personnalisées** | ✅ Supporté | `CustomFunctionManager` |
| **Données liées (Linked Entities)** | ✅ Supporté | `LinkedEntityDataDomain`, `EntityCellValue` |
| **Power Query** | ✅ Supporté | `Query`, `QueryCollection` |
| **Contrôles de cellules** | ✅ Supporté | `CheckboxCellControl` |
| **Calcul itératif** | ✅ Supporté | `IterativeCalculation` |

### Non supportées / Limitations

| Fonctionnalité | Statut | Notes |
|---|---|---|
| **PivotTables OLAP** | ❌ Non supporté | Seuls les PivotTables standards sont supportés |
| **Power Pivot** | ❌ Non supporté | Pas d'accès aux données Power Pivot |
| **Sparklines** | ❌ Pas dans l'API | Aucune classe `Sparkline` n'existe |
| **VBA / Macros** | ❌ Pas dans l'API | Impossible d'exécuter ou créer des macros VBA |
| **SmartArt** | ❌ Pas dans l'API | Pas de création ou manipulation de SmartArt |
| **Content Controls** | ❌ Pas dans l'API | Rich Text Content Controls non accessibles |
| **Onglets ruban intégrés** | ❌ Limité | Accès uniquement au ruban personnalisé via manifest |
| **Groupe de feuilles** | ❌ Pas dans l'API | Pas de classe `WorksheetGroup` |
| **Sauvegarde explicite** | ❌ Auto-save | Excel gère la sauvegarde automatiquement |

---

Développé par [Yann Assoumou](https://github.com/yannassoumou) — open source sous MIT License.
