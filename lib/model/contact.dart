import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int number;
  @HiveField(2)
  final String mail;
  Contact({
    required this.name,
    required this.number,
    required this.mail,
  });
}
