import 'package:flutter/material.dart';
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
          if (value.values.isEmpty) {
            return const Text("Empty Box");
          } else {
            return const Text("Found Data ");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}


// TextField - Name, Age