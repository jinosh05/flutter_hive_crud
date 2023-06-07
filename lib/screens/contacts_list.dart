import 'package:flutter/material.dart';
import 'package:flutter_hive_crud/screens/add_contact.dart';
import 'package:flutter_hive_crud/model/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key, required this.box});
  final Box? box;
  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts List ")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(
          "contacts",
        ).listenable(),
        builder: (BuildContext context, Box value, Widget? _) {
          debugPrint("Building ${value.values.length}");
          if (value.values.isEmpty) {
            return const Center(child: Text("Empty Box - No Contents"));
          } else {
            return ListView.builder(
              itemCount: value.values.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (BuildContext context, int index) {
                final message = value.getAt(index) as Message;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      message.age.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddMessageScreen();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
