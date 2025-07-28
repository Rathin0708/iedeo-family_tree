# Iedeo Family Tree App

A Flutter family tree application built with **MVVM + BLoC architecture** featuring secure authentication, form validation, and cross-platform support.

## 🏗️ Architecture

This project implements a **proper MVVM + BLoC pattern** where:
- **ViewModels** handle business logic and expose state via `ChangeNotifier`
- **BLoC** is used internally by ViewModels for state management
- **Views** bind to ViewModels for UI logic and state updates
- **Repository** pattern for data access and API calls
- **Dependency Injection** for managing dependencies

For detailed architecture documentation, see [MVVM_BLOC_ARCHITECTURE.md](MVVM_BLOC_ARCHITECTURE.md).

## ✨ Features

- 🔐 **Secure Authentication** - Login/Signup with form validation
- 📱 **Cross-Platform** - Runs on Android, iOS, and Web
- 🎨 **Material 3 Design** - Modern UI with custom theming
- 🔒 **Secure Storage** - Token and user data encryption
- ✅ **Form Validation** - Real-time validation with custom validators
- 🏛️ **Clean Architecture** - MVVM + BLoC pattern implementation

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio / VS Code
- Android SDK with NDK 27.0.12077973
- Chrome (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd iedeo_family_tree
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   **For Web:**
   ```bash
   flutter run -d chrome
   ```
   
   **For Android (using provided script):**
   ```bash
   ./run_android.sh
   ```
   
   **For Android (manual):**
   ```bash
   ANDROID_NDK_ROOT=/Users/rathin/Library/Android/sdk/ndk/27.0.12077973 flutter run -d <device-id>
   ```

## 📱 Build APK

Use the provided build script for easy APK generation:

```bash
./build_android.sh
```

Or manually:
```bash
ANDROID_NDK_ROOT=/Users/rathin/Library/Android/sdk/ndk/27.0.12077973 flutter build apk --debug
```

## 🔑 Test Credentials

For testing the authentication:
- **Email:** `test@example.com`
- **Password:** `password`

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # App constants (colors, strings)
│   ├── di/                 # Dependency injection
│   ├── errors/             # Error handling
│   ├── theme/              # App theming
│   └── utils/              # Utilities and validators
├── data/
│   ├── models/             # Data models
│   └── repositories/       # Data repositories
└── presentation/
    ├── bloc/               # BLoC state management
    ├── screens/            # UI screens
    ├── viewmodels/         # MVVM ViewModels
    └── widgets/            # Reusable widgets
```

## 🛠️ Dependencies

- `flutter_bloc` - State management
- `equatable` - Value equality
- `formz` - Form validation
- `http` - HTTP client
- `flutter_secure_storage` - Secure data storage
- `go_router` - Navigation

## 🐛 Troubleshooting

### Android Build Issues

If you encounter NDK version mismatch errors:

1. **Clean the project:**
   ```bash
   flutter clean
   rm -rf build/
   rm -rf android/.gradle/
   ```

2. **Ensure NDK 27.0.12077973 is installed:**
   ```bash
   sdkmanager --install "ndk;27.0.12077973"
   ```

3. **Use the provided scripts** which set the correct NDK path automatically

### Common Issues

- **Build errors:** Run `flutter doctor` to check your setup
- **Device not detected:** Enable USB debugging on Android devices
- **Web issues:** Ensure Chrome is installed and updated

## 🚧 Development Status

- ✅ Authentication system
- ✅ MVVM + BLoC architecture
- ✅ Cross-platform support
- ✅ Form validation
- ✅ Secure storage
- 🚧 Family tree builder (coming soon)
- 🚧 User profiles and settings
- 🚧 Real backend integration

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
