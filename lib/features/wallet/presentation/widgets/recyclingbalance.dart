import 'package:austriapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecyclingBalance extends StatelessWidget {
  final double balance;

  const RecyclingBalance({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Fondo gris muy oscuro (casi negro)
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12), // Bordes rectos/ligeramente redondeados como la imagen
        border: Border.all(
          color: AppColors.neonGreen, // El borde verde neón
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonGreen.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // Alineamos monto a la derecha/centro
        children: [
          // --- Fila Superior: Título e Icono ---
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Saldo Disponible por Recolección',
                  style: TextStyle(
                    color: Colors.white, // Texto blanco manuscrito/script en la imagen
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Handwriting', // Si tuvieras una fuente manuscrita, iría aquí
                  ),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.recycling, 
                color: AppColors.neonGreen, 
                size: 28,
              ),
            ],
          ),

          const SizedBox(height: 15),

          // --- Monto ---
          Text(
            '${balance.toStringAsFixed(2)} MXN',
            style: const TextStyle(
              color: AppColors.neonGreen, // Color del dinero
              fontSize: 36, // Tamaño grande
              fontWeight: FontWeight.w300, // Letra delgada como en la imagen
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}