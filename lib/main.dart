import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationDocumentsDirectory();
  debugPrint(path.path);
  Hive.init(path.path);

  runApp(const MaterialApp(
      home: Scaffold(
    body: Center(child: HomeScreen()),
  )));
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
      future: _data(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            return const Text("error");
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<int?> _data() async {
    await Future.delayed(const Duration(seconds: 5));
    return 3;
  }
}
