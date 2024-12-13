import 'package:flutter/material.dart';

import 'package:mobile/screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  final TextEditingController _textController = TextEditingController();

  void _addItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter item name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() {
                    items.add(_textController.text);
                  });
                  Navigator.pop(context);
                  _textController.clear();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _onPressItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.article),
            title: Text(items[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _onPressItem,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
