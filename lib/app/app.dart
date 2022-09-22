import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/mahasiswa_service.dart';
import '../ui/shared/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';
import '../ui/shared/year_picker_dialog/year_picker_dialog_view.dart';
import '../ui/views/dashboard/dashboard_view.dart';
import '../ui/views/deteksi/deteksi_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/judul/judul_view.dart';
import '../ui/views/mahasiswa/mahasiswa_view.dart';
import '../ui/views/sign_in/sign_in_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SignInView, initial: true),
    MaterialRoute(page: DashboardView, children: [
      MaterialRoute(page: HomeView, initial: true),
      MaterialRoute(page: MahasiswaView),
      MaterialRoute(page: JudulView),
      MaterialRoute(page: DeteksiView),
    ]),
  ],
  dialogs: [
    StackedDialog(classType: FormMahasiswaDialogView),
    StackedDialog(classType: YearPickerDialogView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: MahasiswaService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
