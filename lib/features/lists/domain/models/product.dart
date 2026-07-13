import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  late String name;
  String? category;
  double quantity = 1.0;
  String unit = 'Unidade'; // Ex: Kg, g, L, ml, Unidade, Pacote
  String? brand;
  double? price;
  String? notes;
  String? iconPath;
  bool isCompleted = false;
  
  // Controle de auditoria local
  DateTime createdAt = DateTime.now();
}
