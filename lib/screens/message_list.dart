import 'package:flutter/material.dart';
import 'package:flutter_hive_crud/screens/add_message.dart';
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
      appBar: AppBar(title: const Text("Messages List ")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(
          "message",
        ).listenable(),
        builder: (BuildContext context, Box value, Widget? _) {
          debugPrint("Building ${value.values.length}");
          if (value.values.isEmpty) {
            return const Text("Empty Box");
          } else {
            return ListView.builder(
              itemCount: value.values.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (BuildContext context, int index) {
                final message = value.getAt(index) as Message;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(message.name),
                    Text(message.age.toString()),
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

// TextField - Name, Age
