import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/app.router.dart';
import 'package:pengajuan_judul_dashboard/ui/views/home/home_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/judul_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  final log = getLogger("DashboardViewModel");

  final _navigationService = locator<NavigationService>();

  void handleNavigation(int idx) {
    if (currentIndex == idx) return;

    setIndex(idx);

    switch (idx) {
      case 0:
        _navigationService.navigateToView(
          const HomeView(),
          id: 1,
          transitionStyle: Transition.fade,
        );
        break;
      case 1:
        _navigationService.navigateToView(
          const MahasiswaView(),
          id: 1,
          transitionStyle: Transition.fade,
        );
        break;
      case 2:
        _navigationService.navigateToView(
          const JudulView(),
          id: 1,
          transitionStyle: Transition.fade,
        );
        break;
    }
  }

  void onLogout() async {
    // TODO: logout
    _navigationService.clearStackAndShow(Routes.signInView);
  }
}
