import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/networks/apis.dart';
import 'package:mobile/widgets/text_field.dart';

class FormScreen extends StatefulWidget {
  final int userId;
  final VoidCallback callback;
  const FormScreen({
    super.key,
    required this.userId,
    required this.callback, // Add to constructor
  });
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
      widget.callback();
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
      widget.callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                  '${snapshot.data!.lastName} ${snapshot.data!.firstName}');
            }
            return const Text('User Detail');
          },
        ),
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
                  TextFieldWidget(
                    title: 'First Name',
                    hintText: 'Enter first name',
                    controller: _textFirstName,
                    enabled: isEdit,
                  ),
                  const SizedBox(height: 8),
                  TextFieldWidget(
                    title: 'Last Name',
                    hintText: 'Enter last name',
                    controller: _textLastName,
                    enabled: isEdit,
                  ),
                  const SizedBox(height: 8),
                  TextFieldWidget(
                    title: 'Email',
                    hintText: 'Enter email',
                    controller: _textEmailName,
                    enabled: isEdit,
                  ),
                  const SizedBox(height: 8),
                  TextFieldWidget(
                    title: 'Phone',
                    hintText: 'Enter phone number',
                    controller: _textPhone,
                    enabled: isEdit,
                  ),
                  const SizedBox(height: 8),
                  TextFieldWidget(
                    title: 'Zip Code',
                    hintText: 'Enter zip code',
                    controller: _textZipCodeName,
                    enabled: isEdit,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isEdit)
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
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
