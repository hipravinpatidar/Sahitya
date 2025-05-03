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

## 📸 Screenshots
<div style="display: flex; overflow-x: auto; gap: 10px; padding: 10px 0;">

  <img src="https://github.com/user-attachments/assets/03c747b5-903a-426f-9eef-30bb1bd6ee8d" alt="Home" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/d4e09875-ab6f-4eec-a206-05e7c8375763" alt="Books List" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/c368e1d0-ece9-41fa-9ca8-23efca0fbbdd" alt="Chapter View" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/5a87e44a-afa1-4624-913e-62bc04485442" alt="Verse Display" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/356f9aa9-5629-436f-8cad-6e701edf93ea" alt="Settings" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/fa1d0259-d274-49c1-a0ba-b29183559b04" alt="Dark Mode" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

  <img src="https://github.com/user-attachments/assets/8b71d526-4a64-4d39-8801-61fd5b4ba506" alt="Bookmarks" style="height: 250px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"/>

</div>
