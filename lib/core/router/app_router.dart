import 'package:austriapp/features/reports/presentation/screens/user_report_screen.dart';
import 'package:austriapp/features/reports/presentation/screens/user_satisfaction_screen.dart';
import 'package:austriapp/features/scanface/presentation/screens/scan_face_screen.dart';
import 'package:austriapp/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:auto_route/auto_route.dart'; 
import 'package:austriapp/features/map/presentation/screens/map_screen.dart';

// Esta parte es necesaria para la generación de código
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MapRoute.page, initial: true),
    AutoRoute(page: ScanFaceRoute.page), 
    AutoRoute(page: WalletRoute.page),
    AutoRoute(page: UserReportRoute.page),
    AutoRoute(page: UserSatisfactionRoute.page), 
  ];
}

/**
 * Comandos utiles:
 * flutter pub run build_runner build --delete-conflicting-outputs
 */