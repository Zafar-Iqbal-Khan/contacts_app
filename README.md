# 📇 Contacts App (Flutter)

A Flutter app inspired by Google Contacts that allows users to manage their personal and favorite contacts with both **online (Firebase)** and **offline (SQLite)** support.

---

## 🚀 Features

### 🏠 Home Screen
- Bottom navigation with two tabs:
  - **Contacts:** All saved contacts.
  - **Favorites:** Only favorite contacts.

### 👤 Contact Management
- **View Contacts**: List all added contacts.
- **Add Contact**: Input name, phone, email.
- **Edit Contact**: Modify existing contact details.
- **Delete Contact**: Remove with confirmation dialog.
- **Contact Profile**: View detailed info.
- **Call Contact**: Tap-to-call functionality.
- **Favorite Toggle**: Mark/unmark favorites.

---

### 🔐 Authentication

- Integrated **Google Sign-In** to allow multiple users to access their own personal contact list.
- Each user's contacts are isolated and stored under their unique Firebase UID.

---

## 🗃️ Database

### 🔁 Hybrid Storage
- **Firebase Firestore** (online sync)
- **SQLite** via `sqflite` (offline storage)

The app loads from local SQLite first and uses Firestore for syncing. Any changes made **offline** are **queued** and **automatically synced** with Firebase once the device regains internet access.

---

## 🧱 Tech Stack


| Layer          | Technology                      |
|----------------|---------------------------------|
| Framework      | Flutter                         |
| State Mgmt     | Provider                        |
| Online DB      | Firebase Firestore              |
| Offline DB     | SQLite using `sqflite`          |
| Offline Sync   | `connectivity_plus`             |
| Calling        | `url_launcher`                  |
| Authentication | `google_sign_in`                |
| Responsiveness | `flutter_screenutil`            |


---

## 🛠 Setup Instructions

### 1. 🔧 Prerequisites
- Flutter 3.x
- Dart SDK
- Firebase project
- Android emulator or physical device

### 2. 🔨 Clone the Repo
```bash
git clone https://github.com/zafar-iqbal-khan/contacts_app.git
cd contacts_app
```

### 3. 📦 Install Dependencies
```bash
flutter pub get
```

### 4. 🔥 Firebase Setup
- Enable Firebase in your Flutter project:
  - Android: Add `google-services.json`
- Enable **Cloud Firestore** from Firebase Console.


### 5. 🔑 Google Sign-In Setup
- Enable **Google Sign-In** in Firebase Console → Authentication → Sign-in method.
- Make sure the SHA-1 key is added for Android in Firebase settings.



### 6. 🛠️ Run the App
```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
│
├── models/
│   ├── contact.dart             # Contact model
│   └── pending_action.dart      # Model for storing pending offline actions (add, update, delete)
│
├── services/
│   ├── firebase_service.dart    # Firebase operations
│   └── local_db_service.dart    # SQLite operations
│
├── providers/
│   └── contact_provider.dart    # App state using Provider
│
├── screens/
│   ├── home_screen.dart         # Main UI with tabs
│   ├── login_screen.dart        # Login screen for Google Sign-In
│   ├── add_edit_contact_screen.dart # Add/Edit contact
│   ├── contacts_screen          # Displays the list of all contacts
│   ├── favourites_screen        # Displays contacts marked as favorites
│   └── contact_detail_screen.dart # View contact detail
│
├── widgets/
│   └── contact_tile.dart        # Reusable widget
│
├── utils/
│   └── validators.dart         # Contains input validation logic for forms (e.g., name, email, phone)
│
└── main.dart                    # App entry point
```

---

## 💡 UX Design

- Based on Material Design guidelines.
- Responsive design for various screen sizes.

---

## 🧪 Testing

- Tested on Android emulator and real devices.
- All core features (add/edit/delete/sync) validated.
- Offline mode tested by disabling internet.

---

## 🙌 Contributing

Feel free to fork and contribute:

```bash
git checkout -b feature/your-feature-name
```

---

## 📜 License

This project is licensed under the MIT License.

---

## ✨ Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [sqflite](https://pub.dev/packages/sqflite)
- [Provider](https://pub.dev/packages/provider)