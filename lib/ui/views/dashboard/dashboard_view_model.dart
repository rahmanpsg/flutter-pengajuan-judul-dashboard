import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/app.router.dart';
import 'package:pengajuan_judul_dashboard/services/auth_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/deteksi/deteksi_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/home/home_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/judul_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../app/app.locator.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  final log = getLogger("DashboardViewModel");

  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  final List<Map<String, dynamic>> items = [
    {
      'icon': UniconsLine.home_alt,
      'label': 'Home',
    },
    {
      'icon': UniconsLine.users_alt,
      'label': 'Mahasiswa',
    },
    {
      'icon': UniconsLine.books,
      'label': 'Judul',
    },
    {
      'icon': UniconsLine.book_reader,
      'label': 'Deteksi',
    },
  ];

  final List<Widget> _views = [
    const HomeView(),
    const MahasiswaView(),
    const JudulView(),
    const DeteksiView(),
  ];

  void handleNavigation(int idx) {
    if (currentIndex == idx) return;

    setIndex(idx);

    _navigationService.navigateToView(
      _views[idx],
      id: 1,
      transitionStyle: Transition.fade,
    );
  }

  void onLogout() async {
    await _authService.logout();
    await _navigationService.clearStackAndShow(Routes.signInView);
  }
}
