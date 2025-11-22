import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Entidad simple de la tarjeta
class CreditCard {
  final String id;
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final String type; // 'Visa' o 'Mastercard'
  final Color color; // Para variar un poco el diseño si se quiere

  CreditCard({
    required this.id,
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.type,
    this.color = Colors.grey,
  });
}

// Notifier con datos simulados
class WalletNotifier extends Notifier<List<CreditCard>> {
  @override
  List<CreditCard> build() {
    return [
      CreditCard(
        id: '1',
        holderName: 'Israel Developer',
        cardNumber: '4567890123454567',
        expiryDate: '12/26',
        type: 'Mastercard',
      ),
      CreditCard(
        id: '2',
        holderName: 'Israel Developer',
        cardNumber: '4123456789019010',
        expiryDate: '09/25',
        type: 'Visa',
      ),
      CreditCard(
        id: '3',
        holderName: 'Israel Developer',
        cardNumber: '3456789012345678',
        expiryDate: '01/28',
        type: 'Amex',
      ),
    ];
  }

  void addCard() {
    // Aquí iría la lógica para abrir un formulario o agregar
    print("Navegando a agregar tarjeta...");
  }
}

final walletProvider = NotifierProvider<WalletNotifier, List<CreditCard>>(WalletNotifier.new);