class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      fullName: map['full_name'] as String? ?? 'Unknown User',
      email: map['email'] as String? ?? '',
      photoUrl: map['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'full_name': fullName, 'email': email, 'photo_url': photoUrl};
  }

  UserModel copyWith({String? fullName, String? email, String? photoUrl}) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, name: $fullName, email: $email)';
}
