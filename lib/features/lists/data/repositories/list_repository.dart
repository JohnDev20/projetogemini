import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../domain/models/shopping_list.dart';
import '../../domain/models/product.dart';

class ListRepository {
  final IsarService _isarService;

  ListRepository(this._isarService);

  // Obter todas as listas ativas (fora da lixeira)
  Future<List<ShoppingList>> getActiveLists() async {
    final isar = await _isarService.db;
    return await isar.shoppingLists
        .filter()
        .isInTrashEqualTo(false)
        .sortByIsFavoriteDesc()
        .thenByLastModifiedAtDesc()
        .findAll();
  }

  // Criar ou atualizar uma lista de compras
  Future<void> saveList(ShoppingList list) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.shoppingLists.put(list);
    });
  }

  // Mover para lixeira
  Future<void> moveListToTrash(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final list = await isar.shoppingLists.get(id);
      if (list != null) {
        list.isInTrash = true;
        list.deletedAt = DateTime.now();
        await isar.shoppingLists.put(list);
      }
    });
  }

  // Adicionar produto a uma lista gerenciando duplicados
  Future<void> addProductToList(int listId, Product newProduct, {bool forceCreateNew = false}) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final list = await isar.shoppingLists.get(listId);
      if (list == null) return;

      await list.products.load();

      // Verifica se o item já existe com o mesmo nome na lista
      Product? existingProduct;
      try {
        existingProduct = list.products.firstWhere((p) => p.name.toLowerCase() == newProduct.name.toLowerCase());
      } catch (_) {
        existingProduct = null;
      }

      if (existingProduct != null && !forceCreateNew) {
        // Incrementa quantidade do produto existente
        existingProduct.quantity += newProduct.quantity;
        await isar.products.put(existingProduct);
      } else {
        // Cria um novo registro de produto
        await isar.products.put(newProduct);
        list.products.add(newProduct);
        await list.products.save();
      }
    });
  }
}
