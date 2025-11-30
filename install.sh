#!/bin/bash
# Installation script for Tokyo Roulette Predictor
# Script de instalación para Tokyo Roulette Predictor

set -e

echo "=================================="
echo "Tokyo Roulette Predictor - Install"
echo "=================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed / Flutter no está instalado"
    echo ""
    echo "Please install Flutter first:"
    echo "Por favor instala Flutter primero:"
    echo ""
    echo "  git clone https://github.com/flutter/flutter.git -b stable --depth 1"
    echo "  export PATH=\"\$PATH:\`pwd\`/flutter/bin\""
    echo "  flutter doctor"
    echo ""
    exit 1
fi

echo "✅ Flutter found / Flutter encontrado"
flutter --version
echo ""

# Check Flutter doctor
echo "Running Flutter doctor..."
echo "Ejecutando Flutter doctor..."
flutter doctor
echo ""

# Install dependencies
echo "Installing project dependencies..."
echo "Instalando dependencias del proyecto..."
flutter pub get
echo ""

# Check if Firebase is configured
if [ ! -f "android/app/google-services.json" ]; then
    echo "⚠️  Warning: Firebase not configured"
    echo "⚠️  Advertencia: Firebase no configurado"
    echo ""
    echo "To configure Firebase / Para configurar Firebase:"
    echo "  1. Create a Firebase project / Crea un proyecto Firebase"
    echo "  2. Download google-services.json / Descarga google-services.json"
    echo "  3. Place it in android/app/ / Colócalo en android/app/"
    echo "  OR / O"
    echo "  Run: flutterfire configure"
    echo ""
fi

echo "✅ Installation complete!"
echo "✅ ¡Instalación completa!"
echo ""
echo "To run the app / Para ejecutar la app:"
echo "  flutter run"
echo ""
echo "To build APK / Para compilar APK:"
echo "  flutter build apk --release"
echo ""
