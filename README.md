🛠️ Architecture

The app follows the MVVM architecture and uses Core Data to persist plugin installation status.
It maintains a clear separation of concerns by defining distinct models for:
	•	API responses
	•	UI representation
	•	Core Data storage

⸻

💻 Tech Stack
	•	SwiftUI
	•	CoreData

⸻

🎁 Bonus Features

✅ Add a “Details” button for each plugin to show more info
✅ Load plugin data from a local JSON file instead of hardcoding
✅ Use SwiftUI
✅ Use async/await for handling background tasks
✅ Add thoughtful UI design or animations

🛑 No third-party libraries were used.

⸻

🚀 Improvements (TODO)
	•	Move string literals into a .strings file for localization and maintainability
	•	Abstract CoreDataHelper to support potential migration to other persistence solutions (e.g., Realm)
	•	Add update functionality to support syncing new plugin versions
	•	Add SwiftUI previews to each view for better design iteration
	•	Include pricing in the UI and support purchasing
	•	Improve accessibility (labels, traits, dynamic type support, VoiceOver)
	•	Add unit tests for business logic and data layer
