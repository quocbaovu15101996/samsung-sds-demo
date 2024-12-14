import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/networks/apis.dart';

class CreateUserDialog extends StatefulWidget {
  final TextEditingController _textFirstName = TextEditingController();
  final TextEditingController _textLastName = TextEditingController();
  final TextEditingController _textEmailName = TextEditingController();
  final TextEditingController _textPhone = TextEditingController();
  final TextEditingController _textZipCodeName = TextEditingController();
  final void Function() refresh;

  CreateUserDialog({Key? key, required this.refresh}) : super(key: key);

  static void show(BuildContext context, void Function() refresh) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateUserDialog(refresh: refresh);
      },
    );
  }

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  @override
  void dispose() {
    widget._textFirstName.dispose();
    widget._textLastName.dispose();
    widget._textEmailName.dispose();
    widget._textPhone.dispose();
    widget._textZipCodeName.dispose();
    super.dispose();
  }

  void onCreate() {
    // Validate required fields
    if (widget._textFirstName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('First name is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget._textLastName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Last name is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget._textEmailName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    CreateUserParams body = new CreateUserParams(
      firstName: widget._textFirstName.text,
      lastName: widget._textLastName.text,
      email: widget._textEmailName.text,
      phone: widget._textPhone.text,
      zipCode: widget._textZipCodeName.text,
    );
    createUser(body).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Create user successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
      widget.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New User'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: widget._textFirstName,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: widget._textLastName,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: widget._textEmailName,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: widget._textPhone,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: widget._textZipCodeName,
              decoration: const InputDecoration(
                labelText: 'Zip Code',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onCreate,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
