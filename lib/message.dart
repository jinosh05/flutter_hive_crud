import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  Message({
    required this.age,
    required this.name,
  });
}
