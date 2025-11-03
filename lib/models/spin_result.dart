class SpinResult {
  final int? id;
  final int number;
  final DateTime timestamp;
  final String method; // 'manual' or 'camera'
  final bool isEuropean;
  
  SpinResult({
    this.id,
    required this.number,
    required this.timestamp,
    required this.method,
    required this.isEuropean,
  });
  
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'number': number,
      'timestamp': timestamp.toIso8601String(),
      'method': method,
      'isEuropean': isEuropean,
    };
  }
  
  factory SpinResult.fromJson(Map<String, dynamic> json) {
    return SpinResult(
      id: json['id'] as int?,
      number: json['number'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      method: json['method'] as String,
      isEuropean: json['isEuropean'] as bool,
    );
  }
  
  String getColorName() {
    if (number == 0 || number == 37) return 'Green';
    const redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36];
    return redNumbers.contains(number) ? 'Red' : 'Black';
  }
}
