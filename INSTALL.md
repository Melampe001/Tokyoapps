# Installation Guide / Guía de Instalación

## English

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher  
- Android Studio or VS Code
- Java JDK 11+
- Android SDK (API 24-35)

### Installation Steps

1. **Install Flutter SDK**
   ```bash
   # Download Flutter
   git clone https://github.com/flutter/flutter.git -b stable --depth 1
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # Verify installation
   flutter doctor
   ```

2. **Install Project Dependencies**
   ```bash
   # Navigate to project directory
   cd Tokyoapps
   
   # Install dependencies
   flutter pub get
   ```

3. **Configure Firebase** (requires Firebase project)
   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase
   flutterfire configure
   ```

4. **Run the Application**
   ```bash
   # Run on connected device or emulator
   flutter run
   
   # Build APK for Android
   flutter build apk --release
   ```

### Troubleshooting

If you encounter network issues during installation:

1. **Manual Dependency Installation**:
   - Download dependencies manually from pub.dev
   - Place them in `.pub-cache` directory
   
2. **Offline Mode**:
   ```bash
   flutter pub get --offline
   ```

3. **Use a VPN or Proxy** if storage.googleapis.com is blocked in your region

---

## Español

### Requisitos Previos
- Flutter SDK 3.0.0 o superior
- Dart SDK 3.0.0 o superior
- Android Studio o VS Code
- Java JDK 11+
- Android SDK (API 24-35)

### Pasos de Instalación

1. **Instalar Flutter SDK**
   ```bash
   # Descargar Flutter
   git clone https://github.com/flutter/flutter.git -b stable --depth 1
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # Verificar instalación
   flutter doctor
   ```

2. **Instalar Dependencias del Proyecto**
   ```bash
   # Navegar al directorio del proyecto
   cd Tokyoapps
   
   # Instalar dependencias
   flutter pub get
   ```

3. **Configurar Firebase** (requiere proyecto Firebase)
   ```bash
   # Instalar FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configurar Firebase
   flutterfire configure
   ```

4. **Ejecutar la Aplicación**
   ```bash
   # Ejecutar en dispositivo conectado o emulador
   flutter run
   
   # Compilar APK para Android
   flutter build apk --release
   ```

### Solución de Problemas

Si encuentras problemas de red durante la instalación:

1. **Instalación Manual de Dependencias**:
   - Descarga las dependencias manualmente desde pub.dev
   - Colócalas en el directorio `.pub-cache`
   
2. **Modo Sin Conexión**:
   ```bash
   flutter pub get --offline
   ```

3. **Usa una VPN o Proxy** si storage.googleapis.com está bloqueado en tu región

### Dependencias Principales

Este proyecto utiliza las siguientes dependencias principales:

- **Firebase**: Autenticación y base de datos
  - `firebase_core: ^2.24.2`
  - `firebase_auth: ^4.16.0`
  - `cloud_firestore: ^4.15.3`
  
- **Pagos**: Procesamiento de pagos con Stripe
  - `flutter_stripe: ^10.1.1`
  
- **ML Kit**: Reconocimiento óptico de caracteres (OCR)
  - `google_mlkit_text_recognition: ^0.11.0`
  
- **UI/Charts**: Visualización de datos
  - `fl_chart: ^0.66.0`
  
- **State Management**: Gestión de estado MVVM
  - `provider: ^6.1.1`

### Configuración de Firebase

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Agrega una aplicación Android
3. Descarga `google-services.json` y colócalo en `android/app/`
4. Configura las reglas de Firestore y Storage según sea necesario

### Configuración de Stripe

1. Crea una cuenta en [Stripe](https://dashboard.stripe.com/)
2. Obtén tus claves API (Publishable Key y Secret Key)
3. Configura las claves en tu archivo de configuración

### Notas de Seguridad

- **No commits secrets**: Nunca subas claves API o secretos al repositorio
- Usa variables de entorno para información sensible
- Configura `.gitignore` apropiadamente

### Enlaces Útiles

- [Documentación de Flutter](https://docs.flutter.dev/)
- [Guía de Firebase para Flutter](https://firebase.flutter.dev/)
- [Documentación de Stripe Flutter](https://pub.dev/packages/flutter_stripe)
- [ML Kit para Flutter](https://pub.dev/packages/google_mlkit_text_recognition)

## Status

**Current Version**: 1.0.0  
**Status**: ⚠️ Dependencies need to be installed  
**Last Updated**: November 2, 2025
