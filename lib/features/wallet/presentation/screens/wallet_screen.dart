import 'package:austriapp/core/theme/app_colors.dart';
import 'package:austriapp/features/map/presentation/widgets/navigation_menu_drawer.dart';
import 'package:austriapp/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:austriapp/features/wallet/presentation/widgets/recyclingbalance.dart';
import 'package:austriapp/features/wallet/presentation/widgets/virtual_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( 
        backgroundColor: Colors.black.withOpacity(0.9),  
        surfaceTintColor: Colors.transparent,  
        scrolledUnderElevation: 0,  
        iconTheme: const IconThemeData(color: AppColors.neonGreen),
      ),
      drawer: const NavigationMenuDrawer(), // Menú lateral
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const RecyclingBalance(balance: 50.00) ,

              const SizedBox(height: 30),

              // --- Listado Scrollable de Tarjetas ---
              Expanded(
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return VirtualCard(
                      holderName: card.holderName,
                      cardNumber: card.cardNumber,
                      cardType: card.type,
                      // logoPath: 'assets/icons/visa.svg', // Ejemplo futuro
                    );
                  },
                ),
              ),

              // --- Botón de Agregar Nuevo Método ---
              _buildAddButton(context, ref),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // Llamamos a la lógica del provider o navegamos a un formulario
        ref.read(walletProvider.notifier).addCard();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.neonGreen, // Botón verde sólido
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonGreen.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: const Center(
          child: Text(
            'Agregar Nuevo Método',
            style: TextStyle(
              color: Colors.black, // Texto negro para contraste
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}