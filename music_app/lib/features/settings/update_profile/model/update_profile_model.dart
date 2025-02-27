class UpdateProfileModel {
  final String username;
  final String email;
  final String phoneNumber;

  UpdateProfileModel({
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  UpdateProfileModel copyWith({
    String? username,
    String? email,
    String? phoneNumber,
  }) {
    return UpdateProfileModel(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
