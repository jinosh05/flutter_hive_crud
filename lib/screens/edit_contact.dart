import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_crud/model/contact.dart';
import 'package:hive/hive.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key, required this.message, required this.index});

  final Contact message;
  final int index;
  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _number = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _name.text = widget.message.name;
    _mail.text = widget.message.mail;
    _number.text = widget.message.number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
      ),
      body: Form(
        key: _form,
        child: Padding(
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
                validator: validator,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: TextFormField(
                  validator: validator,
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
              TextFormField(
                validator: validator,
                controller: _mail,
                decoration: const InputDecoration(
                  fillColor: Colors.white10,
                  filled: true,
                  hintText: "Mail",
                  icon: Icon(
                    Icons.mail,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            if (_form.currentState!.validate()) {
              Navigator.pop(context);
              var contactsBox = await Hive.openBox(
                "contacts",
              );
              await contactsBox.putAt(
                  widget.index,
                  Contact(
                      mail: _mail.text,
                      number: int.parse(_number.text),
                      name: _name.text));
              log("Updated data");
            }
          },
          child: const Text("Add Contacts")),
    );
  }

  String? validator(String? value) {
    if (value == null) {
      return "Field cannot be Empty";
    } else if (value.isEmpty) {
      return "Field cannot be Empty";
    }
    return null;
  }
}
