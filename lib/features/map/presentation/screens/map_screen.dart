import 'package:austriapp/features/map/presentation/widgets/navigation_menu_drawer.dart';
import 'package:austriapp/features/map/presentation/widgets/search_bar_widget.dart';
import 'package:austriapp/features/map/presentation/widgets/transport_selector_widget.dart';
import 'package:auto_route/auto_route.dart'; // <--- FALTABA ESTE
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <--- FALTABA ESTE
import 'package:flutter/material.dart';
import 'package:austriapp/core/theme/app_colors.dart';

// El decorador @RoutePage es crucial para auto_route.
@RoutePage()
class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      drawer: NavigationMenuDrawer(),
      body: Stack(
        children: [
          // 1. Fondo del Mapa
          Positioned.fill(
            child: MapBackgroundWidget(),
          ),

          // 2. Elementos de UI Superiores
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SearchBarWidget(),
                ),
                Spacer(),
                TransportSelectorWidget(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Widgets Modulares (El resto del código queda igual)
// -----------------------------------------------------------------------------

class MapBackgroundWidget extends StatelessWidget {
  const MapBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mapBackground,
      child: Center(
        child: Text(
          'Mapa de Rutas (Imagen o Widget de Mapa)',
          style: TextStyle(color: AppColors.neonGreen, fontSize: 18),
        ),
      ),
    );
  }
}

