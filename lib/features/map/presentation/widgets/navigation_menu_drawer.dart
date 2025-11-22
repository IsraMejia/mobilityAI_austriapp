import 'package:austriapp/core/theme/app_colors.dart';
import 'package:austriapp/features/map/presentation/providers/navigation_menu_drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationMenuDrawer extends ConsumerWidget {
  const NavigationMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos la lista de items del estado
    final menuItems = ref.watch(navigationMenuProvider);
    // Obtenemos el controlador para ejecutar funciones
    final menuController = ref.read(navigationMenuProvider.notifier);

    return Drawer(
      // Fondo oscuro consistente con la App
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // --- HEADER ---
          _buildDrawerHeader(),

          // --- LISTA DE OPCIONES ---
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: menuItems.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey[900]),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(item.icon, color: AppColors.neonGreen),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => menuController.onItemSelected(context, item.route),
                );
              },
            ),
          ),

          // --- FOOTER (Opcional: Versión o Logout) ---
          _buildDrawerFooter(),
        ],
      ),
    );
  }

  // Helper: Header del Drawer
  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.darkGreyBar,
        border: Border(
          bottom: BorderSide(color: AppColors.neonGreen, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.neonGreen,
            child: Icon(Icons.person, color: Colors.black, size: 35),
          ),
          const SizedBox(height: 15),
          const Text(
            'Hola, Viajero',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Ver perfil',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Footer simple
  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(Icons.logout, color: Colors.grey[600], size: 20),
          const SizedBox(width: 10),
          Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}