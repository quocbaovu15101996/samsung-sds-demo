import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      labelText: 'Field ${index + 1}',
                      border: const OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle edit action here
                    // Access values using controllers[index].text
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}