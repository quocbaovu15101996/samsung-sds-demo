import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/models/user.dart';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://localhost:9191/users'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);

    return jsonResponse.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
