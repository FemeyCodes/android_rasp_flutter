# android_rasp_flutter

A Flutter plugin providing **Real-time Application Self-Protection (RASP)** using the native Securevale Android RASP library.

## Getting Started

This plugin project is a wrapper for SecureVale android-rasp 0.7.1
[plug-in package](https://pub.dev/packages/android_rasp_flutter),
a specialized package that includes platform-specific implementation code for
Android.

For help knowing about android-rasp, view the
[online repository](https://github.com/securevale/android-rasp), which offers full reference on the Kotlin Internals.

## 📦 Installation

Add `android_rasp_flutter` to your `pubspec.yaml`:

```yaml
dependencies:
  android_rasp_flutter: ^0.0.2
```

## ⚙️ Android Setup

### 1. MavenCentral

Ensure `mavenCentral()` is in your `android/build.gradle` file:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

```

### 2. ProGuard Rules (Mandatory)

To ensure the security checks aren't stripped in Release builds, add these to your `android/app/proguard-rules.pro`:

```proguard
-keep class com.securevale.rasp.android.api.** { *; }
-keep class com.securevale.rasp.android.api.result.** { *; }
# Replace with your app's actual package name
-keep class com.your.package.name.BuildConfig { *; }

```

---

## 🚀 Usage

### One-Time Security Check

Perfect for checking status during app splash screen or before login.

```dart
SecurityStatus status = await AndroidRasp.securityStatus;

if (status != SecurityStatus.secure) {
  print("Threat detected: $status");
  // Handle threat (e.g., show alert or exit)
}

```

### Real-Time Threat Monitoring

Listen for security events (like a debugger being attached) while the app is running.

```dart
AndroidRasp.securityEvents.listen((status) {
  print("Real-time threat detected: $status");
});

```

---

## 📄 Detection Labels

The plugin returns one of the following SecurityStatus enum value types:
| Label | Description |
| :--- | :--- |
| `SecurityStatus.secure` | No threats detected. |
| `SecurityStatus.rooted` | The device is rooted. |
| `SecurityStatus.emulator` | App is running on a virtual device. |
| `SecurityStatus.debugger` | A debugger is attached or active. |
| `SecurityStatus.unknown` | Status could not be determined. |
