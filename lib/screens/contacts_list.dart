import 'package:flutter/material.dart';
import 'package:flutter_hive_crud/model/contact.dart';
import 'package:flutter_hive_crud/screens/add_contact.dart';
import 'package:flutter_hive_crud/screens/edit_contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageList extends StatefulWidget {
  const MessageList({required this.box, super.key});
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
                final message = value.getAt(index) as Contact;

                return _ContactCard(
                  message: message,
                  index: index,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddMessageScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.message,
    required this.index,
  });

  final Contact message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.secondary,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize! * 3,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    message.number.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  Text(
                    message.mail,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditContact(message: message, index: index);
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: Colors.greenAccent,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final contactsBox = await Hive.openBox(
                      "contacts",
                    );
                    await contactsBox.deleteAt(index);
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    size: 27,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
