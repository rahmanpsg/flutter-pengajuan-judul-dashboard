import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/services/auth_service.dart';
import 'package:pengajuan_judul_dashboard/services/mahasiswa_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'firebase_options.dart';
import 'services/dosen_service.dart';
import 'services/judul_service.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();
  setupDialogUi();

  syncAllData();

  Intl.defaultLocale = 'id_ID';
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Pengajuan Judul Skripsi',
      theme: appTheme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: !locator<AuthService>().isLoggedIn
          ? Routes.signInView
          : Routes.dashboardView,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
    );
  }
}

Future<void> resetLocator() async {
  await locator.reset();

  setupLocator();
  setupDialogUi();

  await syncAllData();
}

Future<void> syncAllData() async {
  if (!locator<AuthService>().isLoggedIn) return;

  locator<MahasiswaService>().syncData();
  locator<DosenService>().syncData();
  locator<JudulService>().syncData();
}
