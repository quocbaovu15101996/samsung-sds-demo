class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.zipCode,
  });

  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String? phone;
  late final String? zipCode;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'zipCode': zipCode,
    };
  }
}

class CreateUserParams {
  CreateUserParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.zipCode,
  });

  late final String firstName;
  late final String lastName;
  late final String email;
  late final String? phone;
  late final String? zipCode;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'zipCode': zipCode,
    };
  }
}
