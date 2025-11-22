import 'package:austriapp/features/map/presentation/widgets/navigation_menu_drawer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:austriapp/features/reports/presentation/providers/user_satisfaction_provider.dart';
import 'package:austriapp/core/theme/app_colors.dart'; // Asegúrate de tener tu AppColors con neonGreen

@RoutePage()
class UserSatisfactionScreen extends ConsumerWidget {
  const UserSatisfactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userSatisfactionProvider);
    final notifier = ref.read(userSatisfactionProvider.notifier);
    
    // Usamos LayoutBuilder para calcular la altura disponible para el campo de texto
    return LayoutBuilder(
      builder: (context, constraints) {
        // Altura disponible total menos el padding y el espacio de los otros elementos
        final double screenHeight = constraints.maxHeight;
        // Asignamos el 40% de la altura total al campo de comentarios
        final double commentsHeight = screenHeight * 0.30;

        return Scaffold(
          drawer:const NavigationMenuDrawer() ,
          backgroundColor: Colors.black, // Fondo negro puro
          appBar: AppBar(
            title: const Text('Satisfacción de Usuario', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.black, // Color negro para continuidad total
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.neonGreen),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Título principal
                _buildTitle(),
                const SizedBox(height: 30),

                // 2. Botones de Calificación
                _buildRatingButtons(state, notifier),
                const SizedBox(height: 40),

                // 3. Sección de Comentarios Título
                _buildCommentsTitle(),
                const SizedBox(height: 12),

                // 4. Campo de Comentarios (40% Altura)
                _buildCommentsField(state, notifier, commentsHeight),
                
                // Espacio extra para asegurar el padding del botón
                const SizedBox(height: 30), 

                // 5. Botón de Enviar Encuesta
                _buildSubmitButton(state, notifier, context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Helper Widgets (Modularización)
  // ---------------------------------------------------------------------------

  Widget _buildTitle() {
    return const Text(
      '¿Cómo calificarías tu experiencia?',
      style: TextStyle(
        color: AppColors.neonGreen, 
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildRatingButtons(UserSatisfactionState state, UserSatisfactionNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _RatingButton(
          emoji: '😔',
          label: 'Malo',
          rating: SatisfactionRating.malo,
          currentRating: state.rating,
          onSelected: notifier.updateRating,
        ),
        _RatingButton(
          emoji: '😐',
          label: 'Regular',
          rating: SatisfactionRating.regular,
          currentRating: state.rating,
          onSelected: notifier.updateRating,
        ),
        _RatingButton(
          emoji: '😊',
          label: 'Bueno',
          rating: SatisfactionRating.bueno,
          currentRating: state.rating,
          onSelected: notifier.updateRating,
        ),
      ],
    );
  }

  Widget _buildCommentsTitle() {
    return const Text(
      'Comentarios Adicionales',
      style: TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  Widget _buildCommentsField(UserSatisfactionState state, UserSatisfactionNotifier notifier, double height) {
    // Usamos el Container para forzar la altura calculada
    return Container(
      height: height, 
      child: TextFormField(
        initialValue: state.comments,
        onChanged: notifier.updateComments,
        maxLines: null, // Permite que el TextField use toda la altura del Container
        minLines: null,
        expands: true, // Hace que el texto se expanda dentro del Container
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: AppColors.neonGreen,
        textAlignVertical: TextAlignVertical.top, // Alinea el texto en la parte superior
        decoration: InputDecoration(
          hintText: 'Escribe aquí tus comentarios para mejorar...',
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          filled: true,
          fillColor: Colors.grey.shade900,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.neonGreen, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(UserSatisfactionState state, UserSatisfactionNotifier notifier, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: state.rating != null ? notifier.submitSurvey : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5, 
          shadowColor: AppColors.neonGreen.withOpacity(0.4),
          disabledBackgroundColor: AppColors.neonGreen.withOpacity(0.3),
        ),
        child: const Text(
          'ENVIAR ENCUESTA',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
} 

// Widget auxiliar para los botones de calificación (_RatingButton)
class _RatingButton extends StatelessWidget {
  final String emoji; // Cambiado de 'icon' a 'emoji' para mayor claridad
  final String label;
  final SatisfactionRating rating;
  final SatisfactionRating? currentRating;
  final ValueChanged<SatisfactionRating> onSelected;

  const _RatingButton({
    required this.emoji,
    required this.label,
    required this.rating,
    required this.currentRating,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentRating == rating;

    return GestureDetector(
      onTap: () => onSelected(rating),
      child: AnimatedContainer( // Añadimos animación para transiciones suaves
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: MediaQuery.of(context).size.width / 3.8, // Para que ocupen un tercio del ancho
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonGreen : Colors.grey.shade900, // Fondo más oscuro si no seleccionado
          borderRadius: BorderRadius.circular(15), // Bordes suaves
          border: Border.all(
            color: isSelected ? AppColors.neonGreen : Colors.grey.shade800, // Borde sutil
            width: isSelected ? 2 : 1, // Borde más grueso si seleccionado
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neonGreen.withOpacity(0.5), // Sombra neón para el seleccionado
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [], // Sin sombra si no seleccionado
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 48), // Emoji más grande
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white, // Texto negro si seleccionado, blanco si no
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}