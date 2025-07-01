# 🎬 Final Cut Pro Plugin Manager

A lightweight SwiftUI app that manages Final Cut Pro plugins using MVVM architecture and Core Data for persistence.

---

## 🛠️ Architecture

The app follows the **MVVM architecture** and uses **Core Data** to persist plugin installation status.  
It maintains a clear separation of concerns by defining distinct models for:

- API responses  
- UI representation  
- Core Data storage

## Features
 - Install/Uninstall persist even if you closed the app
 - Add pagination (upto page 2) - plugins-page-1.json and plugins-page-2.json
 - Add single page syncing (version updates) - see plugins-sync.json
 - Detail View with provision for images
 - Re-usable views

---

## 📸 Screenshots / Recordings

![image](https://github.com/user-attachments/assets/04e4ed92-b3e6-47c6-989f-bf6c074ebfe6)
![final-cut](https://github.com/user-attachments/assets/3c83a392-31ed-4352-b998-ad3496b9990b)

---

## 💻 Tech Stack

- `SwiftUI`  
- `CoreData`

---

## 🎁 Bonus Features

- ✅ Add a “Details” button for each plugin to show more info  
- ✅ Load plugin data from a local JSON file instead of hardcoding  
- ✅ Use SwiftUI  
- ✅ Use `async/await` for handling background tasks  
- ✅ Add thoughtful UI design or animations

> 🛑 **No third-party libraries** were used.

---

## 🚀 Improvements (TODO)

- [ ] Move string literals into a `.strings` file for localization and maintainability  
- [ ] Abstract `CoreDataHelper` to support potential migration to other persistence solutions (e.g., Realm)  
- [ ] Add update functionality to support syncing new plugin versions  
- [ ] Add SwiftUI previews to each view for better design iteration  
- [ ] Include pricing in the UI and support purchasing  
- [ ] Improve accessibility (labels, traits, dynamic type support, VoiceOver)  
- [ ] Add unit tests for business logic and data layer
- [ ] Add real image from url
---

## Notes:
- Image URLs not are real resulting in infinite loading state.


