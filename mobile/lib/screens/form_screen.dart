import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/networks/apis.dart';

class FormScreen extends StatefulWidget {
  final int userId;
  const FormScreen({super.key, required this.userId});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late Future<User> user;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    user = fetchUserDetail(widget.userId);
    // print("user: ${user}");
  }

  final TextEditingController _textFirstName = TextEditingController();
  final TextEditingController _textLastName = TextEditingController();
  final TextEditingController _textEmailName = TextEditingController();
  final TextEditingController _textPhone = TextEditingController();
  final TextEditingController _textZipCodeName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onStartEdit() {
    setState(() {
      isEdit = true;
    });
  }

  void onSave() {
    User body = new User(
      id: widget.userId,
      firstName: _textFirstName.text,
      lastName: _textLastName.text,
      email: _textEmailName.text,
      phone: _textPhone.text,
      zipCode: _textZipCodeName.text,
    );
    updateUser(widget.userId, body).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    });
  }

  void onDelete() {
    deleteUser(widget.userId).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted successfully'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onStartEdit,
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!;
            _textFirstName.text = userData.firstName;
            _textLastName.text = userData.lastName;
            _textEmailName.text = userData.email;
            _textPhone.text = userData.phone ?? '';
            _textZipCodeName.text = userData.zipCode ?? '';
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'User ID: ${userData.id}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  TextField(
                    controller: _textFirstName,
                    enabled: isEdit,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _textLastName,
                    enabled: isEdit,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _textEmailName,
                    enabled: isEdit,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _textPhone,
                    enabled: isEdit,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _textZipCodeName,
                    enabled: isEdit,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: onSave,
                          child: const Text('Save'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: onDelete,
                          child: const Text('Delete'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
