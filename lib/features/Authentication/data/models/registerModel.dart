import 'dart:convert';

class Registermodel {
  final String email;
  final String password;
  final String name;

  Registermodel({
    required this.email,
    required this.password,
    required this.name,
  });

  Registermodel copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return Registermodel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory Registermodel.fromMap(Map<String, dynamic> map) {
    return Registermodel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Registermodel.fromJson(String source) => Registermodel.fromMap(json.decode(source));

  @override
  String toString() => 'Registermodel(email: $email, password: $password, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Registermodel && other.email == email && other.password == password && other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ name.hashCode;
}
