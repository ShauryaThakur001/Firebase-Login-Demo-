class UserModel {
  final String name;
  final String email;
  final String profilePic;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profilePic': profilePic,
    };
  }
}
