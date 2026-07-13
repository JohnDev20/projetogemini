import 'package:isar/isar.dart';
import 'product.dart';

part 'shopping_list.g.dart';

@collection
class ShoppingList {
  Id id = Isar.autoIncrement;

  late String name;
  String? folderName; // Organizar por pastas ou grupos
  bool isFavorite = false;
  bool isInTrash = false;
  DateTime? deletedAt;
  
  String? marketName;
  DateTime createdAt = DateTime.now();
  DateTime? lastModifiedAt;

  // Relacionamento com produtos
  final products = IsarLinks<Product>();
}
