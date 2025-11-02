/// Utility functions for common operations

/// Format roulette number for display (handles 00 representation)
String formatRouletteNumber(int number) {
  return number == 37 ? '00' : '$number';
}

/// Check if a number is valid for given roulette type
bool isValidRouletteNumber(int number, bool isEuropean) {
  if (isEuropean) {
    return number >= 0 && number <= 36;
  } else {
    return number >= 0 && number <= 37; // 37 represents 00
  }
}

/// Parse roulette number from string (handles "00" case)
int? parseRouletteNumber(String text) {
  if (text.trim() == '00') {
    return 37;
  }
  return int.tryParse(text.trim());
}
