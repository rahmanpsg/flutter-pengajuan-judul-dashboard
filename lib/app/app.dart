import 'package:pengajuan_judul_dashboard/services/judul_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/widgets/form_dosen_dialog/form_dosen_dialog_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/dosen_service.dart';
import '../services/mahasiswa_service.dart';
import '../ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import '../ui/views/mahasiswa/widgets/form_mahasiswa_dialog/form_mahasiswa_dialog_view.dart';
import '../ui/shared/year_picker_dialog/year_picker_dialog_view.dart';
import '../ui/views/dashboard/dashboard_view.dart';
import '../ui/views/deteksi/deteksi_view.dart';
import '../ui/views/dosen/dosen_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/judul/judul_view.dart';
import '../ui/views/mahasiswa/mahasiswa_view.dart';
import '../ui/views/sign_in/sign_in_view.dart';
import 'api/firebase_storage_api.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SignInView, initial: true),
    MaterialRoute(page: DashboardView, children: [
      MaterialRoute(page: HomeView, initial: true),
      MaterialRoute(page: MahasiswaView),
      MaterialRoute(page: DosenView),
      MaterialRoute(page: JudulView),
      MaterialRoute(page: DeteksiView),
    ]),
  ],
  dialogs: [
    StackedDialog(classType: YearPickerDialogView),
    StackedDialog(classType: FormMahasiswaDialogView),
    StackedDialog(classType: FormDosenDialogView),
    StackedDialog(classType: FormJudulDialogView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: FirebaseStorageApi),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: MahasiswaService),
    LazySingleton(classType: DosenService),
    LazySingleton(classType: JudulService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
