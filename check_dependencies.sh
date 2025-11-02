#!/bin/bash
# Dependency checker for Tokyo Roulette Predictor
# Verificador de dependencias para Tokyo Roulette Predictor

echo "=================================="
echo "Dependency Checker"
echo "Verificador de Dependencias"
echo "=================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        if [ ! -z "$2" ]; then
            VERSION=$($1 $2 2>&1 | head -1)
            echo "  Version: $VERSION"
        fi
        return 0
    else
        echo -e "${RED}✗${NC} $1 is NOT installed"
        return 1
    fi
}

echo "Checking system requirements..."
echo "Verificando requisitos del sistema..."
echo ""

# Check Flutter
echo "=== Flutter ==="
if check_command flutter "--version"; then
    echo ""
else
    echo -e "  ${YELLOW}Install Flutter:${NC} https://docs.flutter.dev/get-started/install"
    echo ""
fi

# Check Dart
echo "=== Dart ==="
if check_command dart "--version"; then
    echo ""
else
    echo -e "  ${YELLOW}Dart is included with Flutter${NC}"
    echo ""
fi

# Check Git
echo "=== Git ==="
if check_command git "--version"; then
    echo ""
else
    echo -e "  ${YELLOW}Install Git:${NC} https://git-scm.com/downloads"
    echo ""
fi

# Check Java
echo "=== Java ==="
if check_command java "-version"; then
    echo ""
else
    echo -e "  ${YELLOW}Install Java JDK 11+:${NC} https://www.oracle.com/java/technologies/downloads/"
    echo ""
fi

# Check Android SDK
echo "=== Android SDK ==="
if [ -d "$ANDROID_HOME" ] || [ -d "$ANDROID_SDK_ROOT" ]; then
    echo -e "${GREEN}✓${NC} Android SDK path is set"
    echo "  Path: ${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
    echo ""
else
    echo -e "${RED}✗${NC} Android SDK path not found"
    echo -e "  ${YELLOW}Set ANDROID_HOME or ANDROID_SDK_ROOT environment variable${NC}"
    echo ""
fi

# Check project structure
echo "=== Project Structure ==="
if [ -f "pubspec.yaml" ]; then
    echo -e "${GREEN}✓${NC} pubspec.yaml found"
else
    echo -e "${RED}✗${NC} pubspec.yaml NOT found"
    echo "  Are you in the project root directory?"
fi

if [ -d "lib" ]; then
    echo -e "${GREEN}✓${NC} lib/ directory found"
else
    echo -e "${RED}✗${NC} lib/ directory NOT found"
fi

if [ -d "android" ]; then
    echo -e "${GREEN}✓${NC} android/ directory found"
else
    echo -e "${RED}✗${NC} android/ directory NOT found"
fi

if [ -f "android/app/google-services.json" ]; then
    echo -e "${GREEN}✓${NC} Firebase configured (google-services.json found)"
else
    echo -e "${YELLOW}!${NC} Firebase not configured (google-services.json missing)"
    echo "  Run: flutterfire configure"
fi
echo ""

# Check dependencies
echo "=== Project Dependencies ==="
if [ -d ".dart_tool" ]; then
    echo -e "${GREEN}✓${NC} Dependencies installed (.dart_tool found)"
else
    echo -e "${YELLOW}!${NC} Dependencies not installed"
    echo "  Run: flutter pub get"
fi
echo ""

# Run Flutter doctor if Flutter is available
if command -v flutter &> /dev/null; then
    echo "=== Flutter Doctor ==="
    echo "Running flutter doctor..."
    flutter doctor
fi

echo ""
echo "=================================="
echo "Check complete / Verificación completa"
echo "=================================="
