import 'package:stacked/stacked.dart';

class DashboardViewModel extends IndexTrackingViewModel {
  Future<void> init() async {}

  void handleNavigation(int idx) {
    if (currentIndex == idx) return;
  }
}
