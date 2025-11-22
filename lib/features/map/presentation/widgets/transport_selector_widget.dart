import 'package:austriapp/core/theme/app_colors.dart';
import 'package:austriapp/features/map/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';

class TransportSelectorWidget extends StatelessWidget {
  const TransportSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.darkGreyBar,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TransportIcon(icon: Icons.train, label: 'Tren', isSelected: true),
          _TransportIcon(icon: Icons.directions_bike, label: 'Bici', isSelected: false),
          _TransportIcon(icon: Icons.star_border, label: 'Favorito', isSelected: false),
        ],
      ),
    );
  }
}

class _TransportIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _TransportIcon({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.neonGreenAccent : AppColors.neonGreen;
    return GestureDetector(
      onTap: () => print('Modo: $label'),
      child: Icon(icon, color: color, size: 28),
    );
  }
}