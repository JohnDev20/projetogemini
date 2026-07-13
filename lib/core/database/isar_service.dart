import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/lists/domain/models/product.dart';
import '../../features/lists/domain/models/shopping_list.dart';
import '../../features/lists/domain/models/category.dart';
import '../../features/lists/domain/models/market.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDatabase();
  }

  Future<Isar> openDatabase() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          ProductSchema,
          ShoppingListSchema,
          CustomCategorySchema,
          MarketSchema,
        ],
        directory: dir.path,
        inspector: true, // Habilita o Isar Inspector para depuração em desenvolvimento
      );
    }
    return Isar.getInstance()!;
  }
}
