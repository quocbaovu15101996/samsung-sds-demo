import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/networks/apis.dart';

import 'package:mobile/screens/form_screen.dart';
import 'package:mobile/widgets/create_user_dialog.dart';

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

class _ItemListScreenState extends State<ItemListScreen>
    with WidgetsBindingObserver {
  Future<List<User>> users = fetchUsers();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("diddChangeAppLifecycleState: $state");
    if (state == AppLifecycleState.resumed) {
      _refresh();
    }
  }

  void _refresh() {
    fetchUsers().then((data) {
      setState(() {
        users = Future.value(data);
      });
    });
  }

  void _addItem() {
    CreateUserDialog.show(context, _refresh);
  }

  void _onPressItem(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormScreen(userId: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.article),
                  title: Text(
                      "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _onPressItem(snapshot.data![index].id ?? 0);
                  },
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
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
