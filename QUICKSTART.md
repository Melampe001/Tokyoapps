# Quick Start Guide / Guía de Inicio Rápido

## ⚡ 5-Minute Setup / Configuración en 5 Minutos

### 1️⃣ Prerequisites / Requisitos Previos

- ✅ Flutter SDK installed / Flutter SDK instalado
- ✅ Git installed / Git instalado  
- ✅ Android Studio OR VS Code / Android Studio O VS Code

**Don't have Flutter?** / **¿No tienes Flutter?**
```bash
# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$PWD/flutter/bin"
flutter doctor
```

### 2️⃣ Clone & Install / Clonar e Instalar

**Automatic** / **Automático** (Recommended / Recomendado):
```bash
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
./install.sh        # Linux/Mac
install.bat         # Windows
```

**Manual** / **Manual**:
```bash
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
flutter pub get
```

### 3️⃣ Run / Ejecutar

```bash
flutter run
```

That's it! / ¡Eso es todo! 🎉

---

## 🔧 Configuration / Configuración

### Firebase (Optional but Recommended / Opcional pero Recomendado)

1. **Create Firebase Project** / **Crear Proyecto Firebase**
   - Visit: https://console.firebase.google.com/
   - Click "Add Project" / Haz clic en "Agregar Proyecto"

2. **Add Android App** / **Agregar App Android**
   - Package name: `com.tokyo.roulette_app` (check in `android/app/build.gradle`)
   - Download `google-services.json`
   - Place in `android/app/`

3. **Auto-configure** / **Auto-configurar**:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

### Stripe (For Payments / Para Pagos)

1. Get API keys from https://dashboard.stripe.com/
2. Update in code:
   ```dart
   Stripe.publishableKey = 'pk_test_YOUR_KEY';
   ```

---

## 📱 Build & Deploy / Compilar y Desplegar

### Debug Build / Compilación de Depuración
```bash
flutter run
```

### Release APK / APK de Lanzamiento
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### App Bundle for Play Store / Bundle para Play Store
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

---

## 🐛 Troubleshooting / Solución de Problemas

### Quick Fixes / Soluciones Rápidas

**Problem:** Commands not working / Los comandos no funcionan
```bash
flutter clean
flutter pub get
```

**Problem:** Build errors / Errores de compilación
```bash
cd android && ./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

**Problem:** Dependencies issues / Problemas de dependencias
```bash
flutter pub upgrade
flutter pub get
```

### Check Installation / Verificar Instalación
```bash
./check_dependencies.sh  # Linux/Mac
flutter doctor -v         # All platforms
```

**Need more help?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 📚 Documentation / Documentación

| File | Description |
|------|-------------|
| [README.md](README.md) | Project overview / Vista general del proyecto |
| [INSTALL.md](INSTALL.md) | Detailed installation / Instalación detallada |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Common issues / Problemas comunes |
| [TESTING_GUIDE.md](TESTING_GUIDE.md) | Testing procedures / Procedimientos de prueba |
| [DEPLOYMENT.md](DEPLOYMENT.md) | Deployment guide / Guía de despliegue |

---

## 🎯 Key Features / Características Principales

- 🎰 **Dual Roulette**: European & American / Europea y Americana
- 🤖 **AI Predictions**: ML-powered / Predicciones con IA
- 📸 **OCR Scanner**: Scan results / Escanear resultados
- 💎 **Freemium Model**: 3 tiers / 3 niveles
- 🌐 **Offline Mode**: Works without internet / Funciona sin internet
- 📊 **3D Charts**: Beautiful visualizations / Visualizaciones hermosas

---

## 🎮 Quick Commands / Comandos Rápidos

```bash
# Install / Instalar
flutter pub get

# Run / Ejecutar
flutter run

# Build / Compilar
flutter build apk

# Test / Probar
flutter test

# Clean / Limpiar
flutter clean

# Check / Verificar
flutter doctor

# Update / Actualizar
flutter pub upgrade
```

---

## 📞 Support / Soporte

- 📖 Documentation / Documentación: See [INSTALL.md](INSTALL.md)
- 🐛 Issues / Problemas: https://github.com/Melampe001/Tokyoapps/issues
- 💬 Discussions / Discusiones: https://github.com/Melampe001/Tokyoapps/discussions

---

## 🚀 What's Next? / ¿Qué Sigue?

1. ✅ Install dependencies / Instalar dependencias
2. 🔧 Configure Firebase / Configurar Firebase
3. 📱 Run on device / Ejecutar en dispositivo
4. 🧪 Test features / Probar características
5. 🎨 Customize / Personalizar
6. 🚀 Deploy / Desplegar

**Happy coding!** / **¡Feliz programación!** 💻✨

---

**Version:** 1.0.0  
**Last Updated:** November 2, 2025
