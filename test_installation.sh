#!/bin/bash
# Integration test for installation infrastructure
# Prueba de integración para infraestructura de instalación

echo "=========================================="
echo "Installation Infrastructure Integration Test"
echo "Prueba de Integración de Instalación"
echo "=========================================="
echo ""

PASSED=0
FAILED=0

test_file() {
    if [ -f "$1" ]; then
        echo "✓ $1 exists"
        ((PASSED++))
        return 0
    else
        echo "✗ $1 NOT found"
        ((FAILED++))
        return 1
    fi
}

test_executable() {
    if [ -x "$1" ]; then
        echo "✓ $1 is executable"
        ((PASSED++))
        return 0
    else
        echo "✗ $1 is NOT executable"
        ((FAILED++))
        return 1
    fi
}

test_content() {
    if grep -q "$2" "$1"; then
        echo "✓ $1 contains expected content: '$2'"
        ((PASSED++))
        return 0
    else
        echo "✗ $1 missing expected content: '$2'"
        ((FAILED++))
        return 1
    fi
}

echo "=== Testing Documentation Files ==="
test_file "INSTALL.md"
test_file "QUICKSTART.md"
test_file "TROUBLESHOOTING.md"
test_file "INSTALLATION_COMPLETE.md"
echo ""

echo "=== Testing Installation Scripts ==="
test_file "install.sh"
test_executable "install.sh"
test_file "install.bat"
test_file "check_dependencies.sh"
test_executable "check_dependencies.sh"
echo ""

echo "=== Testing Content ==="
test_content "INSTALL.md" "Prerequisites"
test_content "INSTALL.md" "flutter pub get"
test_content "QUICKSTART.md" "Quick Start"
test_content "TROUBLESHOOTING.md" "Common Issues"
test_content "install.sh" "Flutter"
test_content "install.bat" "Flutter"
test_content "check_dependencies.sh" "flutter"
echo ""

echo "=== Testing README Integration ==="
test_content "README.md" "QUICKSTART.md"
test_content "README.md" "INSTALL.md"
test_content "README.md" "TROUBLESHOOTING.md"
test_content "README.md" "install.sh"
test_content "README.md" "install.bat"
echo ""

echo "=== Testing Script Syntax ==="
bash -n install.sh 2>/dev/null && echo "✓ install.sh syntax valid" && ((PASSED++)) || (echo "✗ install.sh syntax error" && ((FAILED++)))
bash -n check_dependencies.sh 2>/dev/null && echo "✓ check_dependencies.sh syntax valid" && ((PASSED++)) || (echo "✗ check_dependencies.sh syntax error" && ((FAILED++)))
echo ""

echo "=== Testing Multi-language Support ==="
if grep -q "Español" INSTALL.md && grep -q "English" INSTALL.md; then
    echo "✓ INSTALL.md has bilingual support"
    ((PASSED++))
else
    echo "✗ INSTALL.md missing bilingual support"
    ((FAILED++))
fi

if grep -q "Instalación" QUICKSTART.md && grep -q "Installation" QUICKSTART.md; then
    echo "✓ QUICKSTART.md has bilingual support"
    ((PASSED++))
else
    echo "✗ QUICKSTART.md missing bilingual support"
    ((FAILED++))
fi
echo ""

echo "=========================================="
echo "Test Results / Resultados de Prueba"
echo "=========================================="
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo "✓ All tests passed! Installation infrastructure is ready."
    echo "✓ ¡Todas las pruebas pasaron! La infraestructura de instalación está lista."
    exit 0
else
    echo "✗ Some tests failed. Please review the output above."
    echo "✗ Algunas pruebas fallaron. Por favor revisa la salida anterior."
    exit 1
fi
