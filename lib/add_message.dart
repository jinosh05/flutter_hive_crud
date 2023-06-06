import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_crud/message.dart';
import 'package:hive/hive.dart';

class AddMessageScreen extends StatefulWidget {
  const AddMessageScreen({super.key});

  @override
  State<AddMessageScreen> createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends State<AddMessageScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Message UI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _name,
            ),
            TextFormField(
              decoration: const InputDecoration(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _age,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            var messageBox = await Hive.openBox(
              "message",
            );
            await messageBox
                .add(Message(age: int.parse(_age.text), name: _name.text));
            log("Added data");
          },
          child: const Text("Add Message")),
    );
  }
}


// 