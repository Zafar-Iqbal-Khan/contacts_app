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

## 📥 Download APK

You can download the latest release APK here [![Download APK](https://img.shields.io/badge/Download-APK-blue.svg?style=for-the-badge)](https://github.com/Zafar-Iqbal-Khan/contacts_app/raw/main/release_apk/app-release.apk)

---
## 📸 Screenshots

<p align="center">

  <img src="https://github.com/user-attachments/assets/3e494d5a-add7-42db-99de-5cb01a149616" width="250">
  <img src="https://github.com/user-attachments/assets/e8fee6c1-4e0f-4ba9-b15a-78bd312d8e04" width="250">
  <img src="https://github.com/user-attachments/assets/88fb6b99-6d30-4665-ba01-efd2078c95c9" width="250">
  <img src="https://github.com/user-attachments/assets/01436649-c09e-4082-abe3-5f1c185d5abe" width="250">
  <img src="https://github.com/user-attachments/assets/6b737a4b-dce6-4089-aa2e-ebd31c73ad0c" width="250">
  <img src="https://github.com/user-attachments/assets/ebd90bee-8181-4616-8a77-643b63f40045" width="250">
  <img src="https://github.com/user-attachments/assets/7ffd5337-50f7-4826-9a42-3c874fa0d060" width="250">
  <img src="https://github.com/user-attachments/assets/8becdce2-5a9d-4988-8ebb-82a91c0d8866" width="250">
  <img src="https://github.com/user-attachments/assets/031e4c66-b49a-4f21-a151-09a5169495a6" width="250">
  <img src="https://github.com/user-attachments/assets/0b6e710d-a3bd-4019-9551-370052ae2c28" width="250">
  
</p>

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
│   ├── custom_slidable_tile.dart # Reusable widget 
│   └── contact_tile.dart         # Reusable widget
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
