class UserResponse {
  String name;
  String email;
  String birthDate;

  UserResponse({
    required this.name,
    required this.email,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate,
    };
  }
}
