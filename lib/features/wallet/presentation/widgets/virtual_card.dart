import 'package:austriapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class VirtualCard extends StatelessWidget {
  final String holderName;
  final String cardNumber;
  final String cardType;
  final String? logoPath; // Ruta del SVG si lo tuvieras

  const VirtualCard({
    super.key,
    required this.holderName,
    required this.cardNumber,
    required this.cardType,
    this.logoPath,
  });

  // Helper para enmascarar: **** **** **** 1234
  String get _maskedNumber {
    if (cardNumber.length < 4) return cardNumber;
    final lastFour = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $lastFour';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      height: 180,
      decoration: BoxDecoration(
        // Fondo oscuro con un toque de transparencia
        color: const Color(0xFF1A1A1A), 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.neonGreen.withAlpha(100), // Borde sutil neón
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(200),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- Fila Superior: Chip y Logo ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Simulación de Chip
              const Icon(
                Icons.sim_card_outlined, // O Icons.memory
                color: Colors.white54,
                size: 36,
              ),
              // Logo de la marca (Fallback a Icono)
              _buildCardLogo(),
            ],
          ),

          // --- Número de Tarjeta ---
          Text(
            _maskedNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Courier', // Fuente tipo tarjeta
              letterSpacing: 2.0,
            ),
          ),

          // --- Fila Inferior: Nombre y Tipo ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holderName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Tipo de tarjeta pequeño en texto o icono
              Opacity(
                opacity: 0.5,
                child: Text(
                  cardType,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardLogo() {
    // Aquí iría la lógica: if (logoPath != null) return SvgPicture.asset(...);
    // Por ahora, usaremos iconos nativos basados en el tipo string
    IconData iconData;
    if (cardType.toLowerCase().contains('visa')) {
      iconData = Icons.payment; // Icono genérico para Visa
    } else if (cardType.toLowerCase().contains('master')) {
      iconData = Icons.credit_card; // Icono genérico para Master
    } else {
      iconData = Icons.credit_card_off_outlined;
    }

    return Icon(
      iconData,
      color: Colors.white,
      size: 32,
    );
  }
}