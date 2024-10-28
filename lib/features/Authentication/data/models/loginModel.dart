import 'dart:convert';

class Loginmodel {
  final String email;
  final String password;

  Loginmodel({
    required this.email,
    required this.password,
  });

  Loginmodel copyWith({
    String? email,
    String? password,
  }) {
    return Loginmodel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory Loginmodel.fromMap(Map<String, dynamic> map) {
    return Loginmodel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Loginmodel.fromJson(String source) => Loginmodel.fromMap(json.decode(source));

  @override
  String toString() => 'Loginmodel(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Loginmodel && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
