import 'package:flutter/material.dart';

class AddMessageScreen extends StatefulWidget {
  const AddMessageScreen({super.key});

  @override
  State<AddMessageScreen> createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends State<AddMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Message UI"),
      ),
      bottomNavigationBar:
          ElevatedButton(onPressed: () {}, child: const Text("Add Message")),
    );
  }
}
