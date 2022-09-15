import 'package:pengajuan_judul_dashboard/ui/views/dashboard/dashboard_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/home/home_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/judul_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/mahasiswa/mahasiswa_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/sign_in/sign_in_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/shared/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SignInView, initial: true),
    MaterialRoute(page: DashboardView, children: [
      MaterialRoute(page: HomeView, initial: true),
      MaterialRoute(page: MahasiswaView),
      MaterialRoute(page: JudulView),
    ]),
  ],
  dialogs: [
    StackedDialog(classType: FormMahasiswaDialogView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
