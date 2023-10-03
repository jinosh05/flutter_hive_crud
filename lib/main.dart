import 'package:flutter/material.dart';
import 'package:flutter_hive_crud/model/contact.dart';
import 'package:flutter_hive_crud/screens/contacts_list.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationDocumentsDirectory();
  debugPrint(path.path);
  Hive.init(path.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(
    MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox(
        "contacts",
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return MessageList(
              box: snapshot.data,
            );
          } else {
            return const Text("error");
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
