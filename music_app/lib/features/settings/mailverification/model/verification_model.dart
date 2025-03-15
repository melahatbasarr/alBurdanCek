class VerificationModel {
  final String email;
  final String code;
  final DateTime sentTime;
  final bool isVerified;

  VerificationModel({
    required this.email,
    required this.code,
    required this.sentTime,
    this.isVerified = false,
  });

  // Create from JSON
  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      email: json['email'] ?? '',
      code: json['code'] ?? '',
      sentTime: DateTime.parse(json['sentTime'] ?? DateTime.now().toIso8601String()),
      isVerified: json['isVerified'] ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
      'sentTime': sentTime.toIso8601String(),
      'isVerified': isVerified,
    };
  }

  // Create a copy with updated fields
  VerificationModel copyWith({
    String? email,
    String? code,
    DateTime? sentTime,
    bool? isVerified,
  }) {
    return VerificationModel(
      email: email ?? this.email,
      code: code ?? this.code,
      sentTime: sentTime ?? this.sentTime,
      isVerified: isVerified ?? this.isVerified,
    );
  }
} 