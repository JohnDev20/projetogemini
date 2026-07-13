import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class CustomCategory {
  Id id = Isar.autoIncrement;
  late String name;
  late String colorHex; // Armazenado como string ex: "#FF4A4A"
}
