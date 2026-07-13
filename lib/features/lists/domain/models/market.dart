import 'package:isar/isar.dart';

part 'market.g.dart';

@collection
class Market {
  Id id = Isar.autoIncrement;
  late String name;
  String? address;
  String? notes;
}
