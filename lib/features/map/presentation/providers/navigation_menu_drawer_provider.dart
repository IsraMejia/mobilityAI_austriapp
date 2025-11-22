import 'package:austriapp/core/router/app_router.dart'; 
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Modelo simple para los items del menú (Inmutable)
class DrawerItem {
  final String title;
  final IconData icon;
  final PageRouteInfo route;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

// 2. Notifier para manejar la lógica del Drawer
class NavigationMenuNotifier extends Notifier<List<DrawerItem>> {
  @override
  List<DrawerItem> build() {
    // Definimos las opciones estáticas aquí.
    // Por ahora, todas apuntan a MapRoute como se solicitó.
    return [

      const DrawerItem(
        title: 'Mapa', 
        icon: Icons.map_outlined, 
        route: MapRoute(),
      ),

      const DrawerItem(
        title: 'ScanFace', 
        icon: Icons.face_retouching_natural, 
        route: ScanFaceRoute(),  
      ),

      const DrawerItem(
        title: 'Billetera', 
        icon: Icons.account_balance_wallet_outlined, 
        route: WalletRoute(), 
      ),

      const DrawerItem(
        title: 'Reportar Incidente', 
        icon: Icons.warning_amber_rounded, 
        route: UserReportRoute(), 
      ),

      const DrawerItem(
        title: '¿Qué te pareció nuestro servicio?', 
        icon: Icons.sentiment_very_satisfied , 
        route: UserSatisfactionRoute(), 
      ),

    ];
  }

  // Lógica de navegación centralizada
  void onItemSelected(BuildContext context, PageRouteInfo route) {
    // Cerramos el drawer primero
    Scaffold.of(context).closeDrawer();
    
    // Navegamos (usando replace para menú principal o push según prefieras)
    // Usamos replace para que no se apile el historial infinitamente en el menú
    context.router.replace(route);
  }
}

// 3. El Provider expuesto
final navigationMenuProvider = NotifierProvider<NavigationMenuNotifier, List<DrawerItem>>(
  NavigationMenuNotifier.new,
);