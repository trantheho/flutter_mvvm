class UserModel{
  final String name;
  final String age;
  final String email;

  UserModel({required this.name, required this.age, required this.email});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      email: json['email'] ?? '',
    );
  }


  Map<String, dynamic> toJson() => {
    'email': email,
    'age': age,
    'name': name,
  };
}