enum SubscriptionTier {
  free,
  advanced,
  premium,
}

class UserSubscription {
  final String userId;
  final SubscriptionTier tier;
  final DateTime? purchaseDate;
  final DateTime? expiryDate;
  final bool isActive;
  
  UserSubscription({
    required this.userId,
    required this.tier,
    this.purchaseDate,
    this.expiryDate,
    this.isActive = false,
  });
  
  bool get isFree => tier == SubscriptionTier.free;
  bool get isAdvanced => tier == SubscriptionTier.advanced;
  bool get isPremium => tier == SubscriptionTier.premium;
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'tier': tier.toString(),
      'purchaseDate': purchaseDate?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'isActive': isActive,
    };
  }
  
  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      userId: json['userId'] as String,
      tier: SubscriptionTier.values.firstWhere(
        (e) => e.toString() == json['tier'],
        orElse: () => SubscriptionTier.free,
      ),
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'] as String)
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      isActive: json['isActive'] as bool? ?? false,
    );
  }
}
