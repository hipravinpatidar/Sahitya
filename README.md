# 📜 Sahitya - Spiritual Literature App (गीता/वेद/पुराण)

[![Flutter](https://img.shields.io/badge/Flutter-3.19.5-blue)](https://flutter.dev)
[![API](https://img.shields.io/badge/API-RESTful-orange)](https://your-api-docs.com)
[![State Management](https://img.shields.io/badge/State-Provider-purple)](https://pub.dev/packages/provider)

A feature-rich Flutter application for exploring sacred Hindu scriptures with intelligent data management and immersive audio experience.

## 🌟 Divine Features

### 📖 Scripture Explorer
- **Dynamic API Pagination** - Load verses on scroll (No bulk downloads)
- **Smart Local Caching** - JSON storage for offline access
- **Multi-Text Support** - Original Sanskrit + Hindi/English translations

### 🎧 Audio Enlightenment
- **Verse-by-verse Geeta audio** (BG 1.1, BG 2.3 etc.)
- **Background playback** support

### 🔖 Spiritual Bookmarks
- **Save favorite verses** across sessions

## 🛠️ Technical Sadhana

| Aspect              | Implementation Details |
|---------------------|------------------------|
| **Data Fetching**   | Http |
| **Local Storage**   | `getApplicationDocumentsDirectory` + JSON |
| **Audio Engine**    | just_audio + audio_service |
| **State**           | Provider + ChangeNotifier |
| **UI Framework**    | Flutter 3.19 (Material 3) |

