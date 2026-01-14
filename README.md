---

# KoyndexApp

> **A premium personal finance management application built with Flutter and Firebase.**

**KoyndexApp** is a modern cross-platform solution designed to simplify financial tracking. Evolved from an original Python architecture, this version delivers high performance and a distinctive visual identity inspired by **Liquid Glass UI**. It combines translucent aesthetics with a vibrant orange-themed design for a bold and intuitive user experience.

## 📱 Preview

*(Optional: Add a banner image or a row of screenshots here)*

## ✨ Key Features

* **Koyndex Glass UI:** A custom design system featuring "glassmorphism" with warm orange gradients, blur effects, and high-contrast typography.
* **Real-time Synchronization:** Powered by Firebase Firestore for instant data consistency across all devices.
* **Secure Authentication:** User identity management via Firebase Auth (Email/Password).
* **Financial Dashboard:** High-level KPIs tracking total balance, income, and expenses at a glance.
* **Hybrid Storage:** Utilizes Firestore for cloud sync and SharedPreferences for local settings and offline persistence.
* **Transaction Management:** Streamlined workflow for creating, editing, and filtering financial entries (In Development).

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **Backend:** [Firebase](https://firebase.google.com/) (Firestore & Auth)
* **Local Storage:** SharedPreferences
* **Design:** Liquid Glass UI (Amber/Orange Palette)

## 📂 Project Structure

```text
lib/
├── logic/        # Firebase integration and sync services
├── models/       # Data models (Transactions, Categories)
├── screens/      # Feature-specific views (Login, Dashboard)
├── ui/           # Design system, themes, and reusable widgets
└── main.dart     # App entry point and theme configuration

```

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (Latest stable version)
* A Firebase Project

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/Rian1303/KoyndexApp.git
cd KoyndexApp

```


2. **Install dependencies:**
```bash
flutter pub get

```


3. **Firebase Configuration:**
To enable backend features, add your configuration files:
* `android/app/google-services.json`
* `ios/Runner/GoogleService-Info.plist`


4. **Run the app:**
```bash
flutter run

```



## 🗺️ Roadmap

* [x] Initial Koyndex Orange design system
* [x] Firebase Authentication (Email/Password)
* [x] Dashboard with real-time financial KPIs
* [ ] Transaction CRUD logic (In Progress)
* [ ] Interactive financial charts (Pie & Line graphs)
* [ ] Multi-currency support and PDF reports
* [ ] Migration to Provider/Riverpod for state management

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.

---

**Developed by [Rian Pluma**](https://www.google.com/search?q=https://github.com/Rian1303) *Software Developer* | [Contact Me](mailto:rian.pluma.dev@gmail.com)

---
