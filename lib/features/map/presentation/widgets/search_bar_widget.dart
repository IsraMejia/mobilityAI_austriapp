import 'package:austriapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Botón de Menú
        _buildMenuButton(context),

        const SizedBox(width: 15),

        // 2. Campo de Búsqueda (Expandido)
        _buildSearchField(),

        const SizedBox(width: 15),

        // 3. Botón de Tickets
        _buildSearchRouteButton(context),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helper Methods (Componentes internos)
  // ---------------------------------------------------------------------------

  Widget _buildMenuButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
        print('Menú Tocadoooo');
      } ,
      child: const Icon(
        Icons.menu, 
        color: AppColors.neonGreen, 
        size: 30
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.neonGreen, width: 1.5),
        ),
        child: const Text(
          'Find location/destination',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSearchRouteButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.neonGreenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          
          
          Text(
            'Search',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.arrow_circle_right_rounded , 
            color: Colors.black, 
            size: 20
          ),
        ],
      ),
    );
  }
}