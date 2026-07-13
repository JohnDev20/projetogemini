import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/list_repository.dart';
import '../../domain/models/shopping_list.dart';
import 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final ListRepository _repository;

  ListCubit(this._repository) : super(ListInitial());

  Future<void> fetchActiveLists() async {
    emit(ListLoading());
    try {
      final lists = await _repository.getActiveLists();
      emit(ListLoaded(lists));
    } catch (e) {
      emit(ListError("Erro ao carregar as listas de compras."));
    }
  }

  Future<void> createList({required String name, String? folder, String? market}) async {
    try {
      final newList = ShoppingList()
        ..name = name
        ..folderName = folder
        ..marketName = market
        ..lastModifiedAt = DateTime.now();
        
      await _repository.saveList(newList);
      await fetchActiveLists();
    } catch (e) {
      emit(ListError("Não foi possível criar a lista."));
    }
  }

  Future<void> deleteList(int id) async {
    try {
      await _repository.moveListToTrash(id);
      await fetchActiveLists();
    } catch (e) {
      emit(ListError("Erro ao enviar lista para a lixeira."));
    }
  }
}
