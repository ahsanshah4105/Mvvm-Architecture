# 🏗️ MVVM Architecture — Flutter

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.7-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-6.1.2-FF6B35?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**A production-ready Flutter project demonstrating MVVM (Model-View-ViewModel) architecture.**  
Clean separation of concerns, scalable folder structure, REST API integration, and local data persistence — all in one reference implementation.

</div>

---

## 📌 Overview

This repository serves as a **practical MVVM reference** for Flutter developers. It shows how to structure a real-world Flutter app using the MVVM pattern — keeping UI, business logic, and data access cleanly separated and independently testable.

The architecture makes it easy to:
- Swap out APIs without touching the UI layer
- Add new features without breaking existing ones
- Write unit tests for ViewModels in isolation
- Scale the codebase as the app grows

---

## 🏛️ MVVM Architecture

```
┌─────────────────────────────────────────────┐
│                   VIEW                       │
│         (Flutter Widgets / Screens)          │
│   Observes ViewModel via Provider/Consumer   │
└──────────────────┬──────────────────────────┘
                   │  calls methods / listens to state
┌──────────────────▼──────────────────────────┐
│                VIEW MODEL                    │
│     (ChangeNotifier — Business Logic)        │
│   Processes data, manages UI state,          │
│   calls Repository methods                  │
└──────────────────┬──────────────────────────┘
                   │  fetches / saves data
┌──────────────────▼──────────────────────────┐
│                  MODEL                       │
│     (Repository + Data Sources)             │
│   REST API via HTTP · SharedPreferences      │
└─────────────────────────────────────────────┘
```

### Data Flow

```
User Action (Widget)
      │
      ▼
ViewModel.method()          ← ChangeNotifier
      │
      ▼
Repository.fetch()          ← abstracts data source
      │
      ▼
HTTP / SharedPreferences    ← actual data access
      │
      ▼
ViewModel updates state     ← notifyListeners()
      │
      ▼
Consumer rebuilds UI        ← only affected widgets rebuild
```

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Language | Dart 3.7 | Core language |
| Framework | Flutter 3.x | Cross-platform UI |
| State Management | Provider 6.1.2 | ChangeNotifier + Consumer pattern |
| Networking | HTTP 1.3.0 | REST API calls |
| Local Storage | SharedPreferences 2.5.2 | Persistent local data |
| UI Utilities | HexColor 3.0.1 | Hex color support in Flutter |
| Design | Material Design 3 | Consistent UI components |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2          # State management — ChangeNotifier pattern
  http: ^1.3.0              # REST API networking
  shared_preferences: ^2.5.2 # Local key-value persistence
  hexcolor: ^3.0.1          # Hex string to Flutter Color
  cupertino_icons: ^1.0.8   # iOS-style icons
```

---

## 📁 Project Structure

```
lib/
├── models/
│   └── *.dart              # Data classes — pure Dart, no Flutter deps
│
├── viewmodels/
│   └── *_viewmodel.dart    # ChangeNotifier classes — business logic
│                           # Calls repository, exposes state to UI
│
├── views/
│   ├── screens/            # Full-page widgets
│   └── widgets/            # Reusable UI components
│
├── repositories/
│   └── *_repository.dart   # Data access layer — abstracts HTTP / local storage
│
├── services/
│   └── api_service.dart    # HTTP client, base URLs, headers
│
└── main.dart               # App entry point — Provider setup

assets/
└── *                       # Images, fonts, static files
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.7.0`
- Dart SDK `^3.7.0`
- Android Studio / VS Code with Flutter plugin

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/ahsanshah4105/Mvvm-Architecture.git

# 2. Navigate into the project
cd Mvvm-Architecture

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

---

## 🔑 Key Concepts Demonstrated

### 1. ViewModel with ChangeNotifier

```dart
class ExampleViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Item> _items = [];

  bool get isLoading => _isLoading;
  List<Item> get items => _items;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();                    // UI shows loading

    _items = await _repository.getItems();

    _isLoading = false;
    notifyListeners();                    // UI shows data
  }
}
```

### 2. Providing ViewModel to Widget Tree

```dart
// main.dart — register ViewModels once at the top
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ExampleViewModel()),
  ],
  child: MyApp(),
)
```

### 3. Consuming State in UI

```dart
// Widget only rebuilds when notifyListeners() is called
Consumer<ExampleViewModel>(
  builder: (context, viewModel, child) {
    if (viewModel.isLoading) return CircularProgressIndicator();
    return ListView.builder(
      itemCount: viewModel.items.length,
      itemBuilder: (_, i) => ItemTile(viewModel.items[i]),
    );
  },
)
```

### 4. Repository Pattern

```dart
// Repository abstracts the data source from the ViewModel
class ItemRepository {
  final ApiService _api;
  final SharedPreferences _prefs;

  Future<List<Item>> getItems() async {
    try {
      return await _api.fetchItems();     // Try remote first
    } catch (_) {
      return _getCachedItems();           // Fallback to local
    }
  }
}
```

---

## ✅ Why MVVM for Flutter?

| Concern | Without MVVM | With MVVM |
|---|---|---|
| Business logic | Scattered inside widgets | Isolated in ViewModels |
| Testing | Hard — UI and logic mixed | Easy — test ViewModel independently |
| Code reuse | Minimal | ViewModels reused across screens |
| Scalability | Hard to extend | Add features without breaking existing code |
| Readability | Bloated widget files | Each file has a single responsibility |

---

## 📸 Screenshots

> *Add your app screenshots here*
>
> ```
> | Login Screen | Home Screen | Detail Screen |
> |---|---|---|
> | ![login]() | ![home]() | ![detail]() |
> ```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Ahsan Ali Shah** — Flutter & Mobile Application Developer

I build production-grade Flutter apps with clean architecture, solid state management, and polished UIs — delivered on time for clients across Android and iOS.

# 🏗️ MVVM Architecture — Flutter

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.7-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-6.1.2-FF6B35?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**A production-ready Flutter project demonstrating MVVM (Model-View-ViewModel) architecture.**  
Clean separation of concerns, scalable folder structure, REST API integration, and local data persistence — all in one reference implementation.

</div>

---

## 📌 Overview

This repository serves as a **practical MVVM reference** for Flutter developers. It shows how to structure a real-world Flutter app using the MVVM pattern — keeping UI, business logic, and data access cleanly separated and independently testable.

The architecture makes it easy to:
- Swap out APIs without touching the UI layer
- Add new features without breaking existing ones
- Write unit tests for ViewModels in isolation
- Scale the codebase as the app grows

---

## 🏛️ MVVM Architecture

```
┌─────────────────────────────────────────────┐
│                   VIEW                       │
│         (Flutter Widgets / Screens)          │
│   Observes ViewModel via Provider/Consumer   │
└──────────────────┬──────────────────────────┘
                   │  calls methods / listens to state
┌──────────────────▼──────────────────────────┐
│                VIEW MODEL                    │
│     (ChangeNotifier — Business Logic)        │
│   Processes data, manages UI state,          │
│   calls Repository methods                  │
└──────────────────┬──────────────────────────┘
                   │  fetches / saves data
┌──────────────────▼──────────────────────────┐
│                  MODEL                       │
│     (Repository + Data Sources)             │
│   REST API via HTTP · SharedPreferences      │
└─────────────────────────────────────────────┘
```

### Data Flow

```
User Action (Widget)
      │
      ▼
ViewModel.method()          ← ChangeNotifier
      │
      ▼
Repository.fetch()          ← abstracts data source
      │
      ▼
HTTP / SharedPreferences    ← actual data access
      │
      ▼
ViewModel updates state     ← notifyListeners()
      │
      ▼
Consumer rebuilds UI        ← only affected widgets rebuild
```

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Language | Dart 3.7 | Core language |
| Framework | Flutter 3.x | Cross-platform UI |
| State Management | Provider 6.1.2 | ChangeNotifier + Consumer pattern |
| Networking | HTTP 1.3.0 | REST API calls |
| Local Storage | SharedPreferences 2.5.2 | Persistent local data |
| UI Utilities | HexColor 3.0.1 | Hex color support in Flutter |
| Design | Material Design 3 | Consistent UI components |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2          # State management — ChangeNotifier pattern
  http: ^1.3.0              # REST API networking
  shared_preferences: ^2.5.2 # Local key-value persistence
  hexcolor: ^3.0.1          # Hex string to Flutter Color
  cupertino_icons: ^1.0.8   # iOS-style icons
```

---

## 📁 Project Structure

```
lib/
├── models/
│   └── *.dart              # Data classes — pure Dart, no Flutter deps
│
├── viewmodels/
│   └── *_viewmodel.dart    # ChangeNotifier classes — business logic
│                           # Calls repository, exposes state to UI
│
├── views/
│   ├── screens/            # Full-page widgets
│   └── widgets/            # Reusable UI components
│
├── repositories/
│   └── *_repository.dart   # Data access layer — abstracts HTTP / local storage
│
├── services/
│   └── api_service.dart    # HTTP client, base URLs, headers
│
└── main.dart               # App entry point — Provider setup

assets/
└── *                       # Images, fonts, static files
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.7.0`
- Dart SDK `^3.7.0`
- Android Studio / VS Code with Flutter plugin

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/ahsanshah4105/Mvvm-Architecture.git

# 2. Navigate into the project
cd Mvvm-Architecture

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

---

## 🔑 Key Concepts Demonstrated

### 1. ViewModel with ChangeNotifier

```dart
class ExampleViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Item> _items = [];

  bool get isLoading => _isLoading;
  List<Item> get items => _items;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();                    // UI shows loading

    _items = await _repository.getItems();

    _isLoading = false;
    notifyListeners();                    // UI shows data
  }
}
```

### 2. Providing ViewModel to Widget Tree

```dart
// main.dart — register ViewModels once at the top
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ExampleViewModel()),
  ],
  child: MyApp(),
)
```

### 3. Consuming State in UI

```dart
// Widget only rebuilds when notifyListeners() is called
Consumer<ExampleViewModel>(
  builder: (context, viewModel, child) {
    if (viewModel.isLoading) return CircularProgressIndicator();
    return ListView.builder(
      itemCount: viewModel.items.length,
      itemBuilder: (_, i) => ItemTile(viewModel.items[i]),
    );
  },
)
```

### 4. Repository Pattern

```dart
// Repository abstracts the data source from the ViewModel
class ItemRepository {
  final ApiService _api;
  final SharedPreferences _prefs;

  Future<List<Item>> getItems() async {
    try {
      return await _api.fetchItems();     // Try remote first
    } catch (_) {
      return _getCachedItems();           // Fallback to local
    }
  }
}
```

---

## ✅ Why MVVM for Flutter?

| Concern | Without MVVM | With MVVM |
|---|---|---|
| Business logic | Scattered inside widgets | Isolated in ViewModels |
| Testing | Hard — UI and logic mixed | Easy — test ViewModel independently |
| Code reuse | Minimal | ViewModels reused across screens |
| Scalability | Hard to extend | Add features without breaking existing code |
| Readability | Bloated widget files | Each file has a single responsibility |

---

## 📸 Screenshots

> *Add your app screenshots here*
>
> ```
> | Login Screen | Home Screen | Detail Screen |
> |---|---|---|
> | ![login]() | ![home]() | ![detail]() |
> ```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Ahsan Ali Shah** — Flutter & Mobile Application Developer

I build production-grade Flutter apps with clean architecture, solid state management, and polished UIs — delivered on time for clients across Android and iOS.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/ahsan-ali-shah-895aa4283/)
[![Fiverr](https://img.shields.io/badge/Fiverr-Hire%20Me-1DBF73?style=flat&logo=fiverr&logoColor=white)]([https://www.fiverr.com/s/m51PEoZ](https://www.fiverr.com/sellers/ahsanshahkazm/edit))
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat&logo=github)](https://github.com/ahsanshah4105)

---

<div align="center">

**⭐ Star this repo if it helped you understand MVVM in Flutter!**

*Built with Flutter · Dart · Provider · HTTP · SharedPreferences*

</div>[![Fiverr](https://img.shields.io/badge/Fiverr-Hire%20Me-1DBF73?style=flat&logo=fiverr&logoColor=white)](https://www.fiverr.com/s/m51PEoZ)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat&logo=github)](https://github.com/ahsanshah4105)

---

<div align="center">

**⭐ Star this repo if it helped you understand MVVM in Flutter!**

*Built with Flutter · Dart · Provider · HTTP · SharedPreferences*

</div>
