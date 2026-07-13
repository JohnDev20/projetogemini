import 'package:flutter/material.dart';
import '../../../lists/domain/models/shopping_list.dart';

class ShoppingModeScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  const ShoppingModeScreen({super.key, required this.shoppingList});

  @override
  State<ShoppingModeScreen> createState() => _ShoppingModeScreenState();
}

class _ShoppingModeScreenState extends State<ShoppingModeScreen> {
  // Tela focada em simplificar a interface de compras com foco e poucos toques
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B), // Fundo escuro focado no modo de compras noturno/interno
      appBar: AppBar(
        title: Text(widget.shoppingList.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: Center(
              child: Text(
                'Modo Compras Ativo.\nTire distrações e foque no carrinho.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
            ),
          ),
          _buildBottomActionPanel(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Progresso da compra', style: TextStyle(color: Colors.white, fontSize: 13)),
              Text('0/0 (0%)', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.0,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ),
    );
  }

  Widget _buildBottomActionPanel() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total: R\$ 0,00',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              // Finalizar a compra e persistir histórico localmente
            },
            child: const Text('Finalizar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
