import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enumeración para tipificar las opciones de calificación
enum SatisfactionRating {
  malo,
  regular,
  bueno,
}

// 1. Entidad del Estado (Inmutable)
class UserSatisfactionState {
  final SatisfactionRating? rating;
  final String comments;

  const UserSatisfactionState({
    this.rating,
    this.comments = '',
  });

  UserSatisfactionState copyWith({
    SatisfactionRating? rating,
    String? comments,
  }) {
    return UserSatisfactionState(
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
    );
  }
}

// 2. Notifier (Lógica de Negocio)
class UserSatisfactionNotifier extends AutoDisposeNotifier<UserSatisfactionState> {
  
  @override
  UserSatisfactionState build() {
    // Estado inicial: sin calificación y sin comentarios
    return const UserSatisfactionState();
  }

  void updateRating(SatisfactionRating rating) {
    state = state.copyWith(rating: rating);
  }

  void updateComments(String text) {
    state = state.copyWith(comments: text);
  }

  void submitSurvey() {
    // Requisito: Mostrar los valores capturados en consola al enviar
    print("--- ENVIANDO ENCUESTA DE SATISFACCIÓN ---");
    print("Calificación: ${state.rating?.name.toUpperCase() ?? 'No calificado'}");
    print("Comentarios: ${state.comments}");
    print("-----------------------------------------");
    
    // Aquí se realizaría la llamada al servicio API.
  }
}

// 3. Provider Global (autoDispose para limpiar el estado al salir)
final userSatisfactionProvider =
    NotifierProvider.autoDispose<UserSatisfactionNotifier, UserSatisfactionState>(
  UserSatisfactionNotifier.new,
);