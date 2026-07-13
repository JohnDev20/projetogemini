import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/database/isar_service.dart';
import '../../../lists/data/repositories/list_repository.dart';
import '../../../lists/presentation/cubit/list_cubit.dart';
import '../../../lists/presentation/cubit/list_state.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(
        ListRepository(RepositoryProvider.of<IsarService>(context)),
      )..fetchActiveLists(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: AppBar(
          title: const Text(
            'Lista Fácil',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black54),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildQuickStatisticsCard(),
                const SizedBox(height: 24),
                const Text(
                  'Minhas Listas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Expanded(child: _buildListsList(context)),
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => _showCreateListDialog(context),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            );
          }
        ),
      ),
    );
  }

  Widget _buildQuickStatisticsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.shopping_bag_outlined, 'Ativas', '3'),
          Container(height: 40, width: 1, color: Colors.grey.shade200),
          _buildStatItem(Icons.history, 'Histórico', '12'),
          Container(height: 40, width: 1, color: Colors.grey.shade200),
          _buildStatItem(Icons.account_balance_wallet_outlined, 'Meta', '60%'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigoAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildListsList(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        if (state is ListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListLoaded) {
          final lists = state.activeLists;
          if (lists.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma lista ativa encontrada.\nComece tocando no botão "+"',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            itemCount: lists.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final list = lists[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    list.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  subtitle: Text(
                    'Criada em: ${DateFormat('dd/MM/yyyy HH:mm').format(list.createdAt)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (list.isFavorite)
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () {
                          context.read<ListCubit>().deleteList(list.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Implementar navegação para o modo de compras / edição
                  },
                ),
              );
            },
          );
        } else if (state is ListError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }

  void _showCreateListDialog(BuildContext parentContext) {
    final nameController = TextEditingController();
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Nova Lista'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Nome da lista',
              hintText: 'Ex: Compras da semana',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  parentContext.read<ListCubit>().createList(
                        name: nameController.text,
                      );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Criar'),
            ),
          ],
        );
      },
    );
  }
}
