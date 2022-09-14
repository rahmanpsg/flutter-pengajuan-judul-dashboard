// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dashboard/dashboard_view.dart'
    as _i3;
import 'package:pengajuan_judul_dashboard/ui/views/home/home_view.dart' as _i4;
import 'package:pengajuan_judul_dashboard/ui/views/judul/judul_view.dart'
    as _i6;
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view.dart'
    as _i5;
import 'package:pengajuan_judul_dashboard/ui/views/sign_in/sign_in_view.dart'
    as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;

class Routes {
  static const signInView = '/';

  static const dashboardView = '/dashboard-view';

  static const all = <String>{signInView, dashboardView};
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.signInView, page: _i2.SignInView),
    _i1.RouteDef(Routes.dashboardView, page: _i3.DashboardView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SignInView(),
        settings: data,
      );
    },
    _i3.DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.DashboardView(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DashboardViewRoutes {
  static const homeView = '/';

  static const mahasiswaView = '/mahasiswa-view';

  static const judulView = '/judul-view';

  static const all = <String>{homeView, mahasiswaView, judulView};
}

class DashboardViewRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(DashboardViewRoutes.homeView, page: _i4.HomeView),
    _i1.RouteDef(DashboardViewRoutes.mahasiswaView, page: _i5.MahasiswaView),
    _i1.RouteDef(DashboardViewRoutes.judulView, page: _i6.JudulView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i4.HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.MahasiswaView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.MahasiswaView(),
        settings: data,
      );
    },
    _i6.JudulView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.JudulView(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToSignInView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.signInView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedHomeViewInDashboardView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(DashboardViewRoutes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedMahasiswaViewInDashboardView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(DashboardViewRoutes.mahasiswaView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedJudulViewInDashboardView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(DashboardViewRoutes.judulView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
