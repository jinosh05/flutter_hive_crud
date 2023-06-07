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
  final TextEditingController _number = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.white10,
                  filled: true,
                  hintText: "Contact Number",
                  icon: Icon(
                    Icons.phone,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _number,
              ),
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
                .add(Message(age: int.parse(_number.text), name: _name.text));
            log("Added data");
          },
          child: const Text("Add Contacts")),
    );
  }
}
