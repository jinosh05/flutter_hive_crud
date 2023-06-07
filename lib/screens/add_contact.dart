import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_crud/model/message.dart';
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
        title: const Text("Add Contact Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                fillColor: Colors.white10,
                filled: true,
                hintText: "Name",
                icon: Icon(
                  Icons.person,
                ),
              ),
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
            Navigator.pop(context);
            var contactsBox = await Hive.openBox(
              "contacts",
            );
            await contactsBox
                .add(Message(age: int.parse(_age.text), name: _name.text));
            log("Added data");
          },
          child: const Text("Add Contacts")),
    );
  }
}
