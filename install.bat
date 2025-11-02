@echo off
REM Installation script for Tokyo Roulette Predictor (Windows)
REM Script de instalación para Tokyo Roulette Predictor (Windows)

echo ==================================
echo Tokyo Roulette Predictor - Install
echo ==================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo X Flutter is not installed / Flutter no esta instalado
    echo.
    echo Please install Flutter first:
    echo Por favor instala Flutter primero:
    echo.
    echo   Visit: https://docs.flutter.dev/get-started/install/windows
    echo   Visita: https://docs.flutter.dev/get-started/install/windows
    echo.
    pause
    exit /b 1
)

echo √ Flutter found / Flutter encontrado
flutter --version
echo.

REM Check Flutter doctor
echo Running Flutter doctor...
echo Ejecutando Flutter doctor...
flutter doctor
echo.

REM Install dependencies
echo Installing project dependencies...
echo Instalando dependencias del proyecto...
flutter pub get
echo.

REM Check if Firebase is configured
if not exist "android\app\google-services.json" (
    echo ! Warning: Firebase not configured
    echo ! Advertencia: Firebase no configurado
    echo.
    echo To configure Firebase / Para configurar Firebase:
    echo   1. Create a Firebase project / Crea un proyecto Firebase
    echo   2. Download google-services.json / Descarga google-services.json
    echo   3. Place it in android\app\ / Colocalo en android\app\
    echo   OR / O
    echo   Run: flutterfire configure
    echo.
)

echo √ Installation complete!
echo √ ¡Instalacion completa!
echo.
echo To run the app / Para ejecutar la app:
echo   flutter run
echo.
echo To build APK / Para compilar APK:
echo   flutter build apk --release
echo.
pause
