class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl; // Opcional
  // final List<String> emotions; // Emoções registradas

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    // required this.emotions,
  });

  // Converte para JSON (para salvar no banco ou Firebase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      // 'emotions': emotions,
    };
  }

  // Converte JSON para objeto UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      // emotions: List<String>.from(json['emotions'] ?? []),
    );
  }
}
