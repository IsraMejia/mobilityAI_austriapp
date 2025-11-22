// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapScreen(),
      );
    },
    ScanFaceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScanFaceScreen(),
      );
    },
    UserReportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserReportScreen(),
      );
    },
    UserSatisfactionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserSatisfactionScreen(),
      );
    },
    WalletRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletScreen(),
      );
    },
  };
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ScanFaceScreen]
class ScanFaceRoute extends PageRouteInfo<void> {
  const ScanFaceRoute({List<PageRouteInfo>? children})
      : super(
          ScanFaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScanFaceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserReportScreen]
class UserReportRoute extends PageRouteInfo<void> {
  const UserReportRoute({List<PageRouteInfo>? children})
      : super(
          UserReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserReportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserSatisfactionScreen]
class UserSatisfactionRoute extends PageRouteInfo<void> {
  const UserSatisfactionRoute({List<PageRouteInfo>? children})
      : super(
          UserSatisfactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSatisfactionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WalletScreen]
class WalletRoute extends PageRouteInfo<void> {
  const WalletRoute({List<PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
