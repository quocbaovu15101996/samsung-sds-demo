import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/models/user.dart';

String baseUrl = 'http://localhost:9191';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('${baseUrl}/users'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);

    return jsonResponse.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get users');
  }
}

Future<User> fetchUserDetail(int id) async {
  final response = await http.get(Uri.parse('${baseUrl}/users/${id}'));
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to get user info');
  }
}

Future<bool> deleteUser(int id) async {
  final response = await http.delete(Uri.parse('${baseUrl}/users/${id}'));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to delete user');
  }
}

Future<User> updateUser(int id, User body) async {
  final response = await http.put(Uri.parse('${baseUrl}/users/${id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body.toJson()));
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update user');
  }
}

Future<User> createUser(CreateUserParams body) async {
  final response = await http.post(Uri.parse('${baseUrl}/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body.toJson()));
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}
