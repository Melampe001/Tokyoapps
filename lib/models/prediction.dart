class Prediction {
  final List<int> hotNumbers;
  final List<int> coldNumbers;
  final Map<String, double> sectorFrequencies;
  final List<int> suggestedBets;
  final double confidence;
  final String strategy;
  
  Prediction({
    required this.hotNumbers,
    required this.coldNumbers,
    required this.sectorFrequencies,
    required this.suggestedBets,
    required this.confidence,
    required this.strategy,
  });
  
  String getBasicPredictionText() {
    return 'Hot Numbers: ${hotNumbers.take(5).join(', ')}\n'
           'Cold Numbers: ${coldNumbers.take(5).join(', ')}\n'
           '🔒 Upgrade to Advanced (\$199) for sector predictions like Voisins du Zéro!';
  }
  
  String getAdvancedPredictionText() {
    final voisinsFreq = sectorFrequencies['Voisins du Zéro'] ?? 0.0;
    return 'Hot Numbers: ${hotNumbers.take(5).join(', ')}\n'
           'Cold Numbers: ${coldNumbers.take(5).join(', ')}\n'
           'Voisins du Zéro: ${voisinsFreq.toStringAsFixed(1)}%\n'
           '🔒 Upgrade to Premium (\$299) for all sectors and advanced strategies!';
  }
  
  String getPremiumPredictionText() {
    StringBuffer sb = StringBuffer();
    sb.writeln('Hot Numbers: ${hotNumbers.take(5).join(', ')}');
    sb.writeln('Cold Numbers: ${coldNumbers.take(5).join(', ')}');
    sb.writeln('\nSector Analysis:');
    sectorFrequencies.forEach((sector, freq) {
      sb.writeln('$sector: ${freq.toStringAsFixed(1)}%');
    });
    sb.writeln('\nSuggested Bets: ${suggestedBets.join(', ')}');
    sb.writeln('Confidence: ${(confidence * 100).toStringAsFixed(1)}%');
    sb.writeln('Strategy: $strategy');
    return sb.toString();
  }
}
