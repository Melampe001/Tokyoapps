#!/bin/bash

# Tokyo Roulette App - Test Runner Script
# Runs all tests with coverage

set -e  # Exit on error

echo "=========================================="
echo "Tokyo Roulette App - Running Tests"
echo "=========================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n1)"
echo ""

# Clean and get dependencies
echo "📦 Preparing test environment..."
flutter pub get
echo ""

# Run tests with coverage
echo "🧪 Running unit tests..."
if flutter test --coverage; then
    echo ""
    echo "✅ All tests passed!"
    echo ""
else
    echo ""
    echo "❌ Some tests failed. Fix them before proceeding."
    exit 1
fi

# Generate coverage report if lcov is installed
if command -v genhtml &> /dev/null; then
    echo "📊 Generating coverage report..."
    genhtml coverage/lcov.info -o coverage/html
    echo ""
    echo "✅ Coverage report generated!"
    echo "📁 Open: coverage/html/index.html"
    echo ""
    
    # Show coverage summary if available
    if command -v lcov &> /dev/null; then
        echo "📈 Coverage Summary:"
        lcov --summary coverage/lcov.info 2>&1 | grep -E "lines|functions"
        echo ""
    fi
else
    echo "⚠️  lcov not installed. Install to generate HTML coverage report:"
    echo "   Ubuntu/Debian: sudo apt-get install lcov"
    echo "   macOS: brew install lcov"
    echo ""
fi

echo "=========================================="
echo "✅ Test run complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Review any failed tests"
echo "2. Check coverage report"
echo "3. Add tests for uncovered code"
echo "4. Run manual testing checklist"
echo ""
