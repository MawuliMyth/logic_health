class UserModel {
  final String id;
  final String fullName;
  final String email;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    String? photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      fullName: map['full_name'] as String? ?? 'Unknown User',
      email: map['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'full_name': fullName, 'email': email};
  }

  @override
  String toString() => 'UserModel(id: $id, name: $fullName, email: $email)';
}
