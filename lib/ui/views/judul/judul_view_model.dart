import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/app/app.locator.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/enums/form_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/services/judul_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JudulViewModel extends ReactiveViewModel {
  final log = getLogger("JudulViewModel");

  final _dialogService = locator<DialogService>();
  final _judulService = locator<JudulService>();

  int tabIndexSelected = 0;

  List<JudulModel> get list => _judulService.list;

  Future<void> init() async {}

  void setTabIndexSelected(int idx) {
    tabIndexSelected = idx;
    notifyListeners();
  }

  /// [judul] set null if you need to add new the data
  void onAddOrEdit(JudulModel? judul) async {
    bool isEdit = judul != null;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.formJudulDialogView,
      data: FormJudulDialogData(
        type: isEdit ? FormDialogType.edit : FormDialogType.add,
        judul: judul,
      ),
      title: '${isEdit ? 'Edit' : 'Tambah'} Data Judul',
    );

    log.d("response: ${response?.data}");

    if (response?.confirmed != true) return;

    setBusy(true);

    final result = await _judulService.save(response!.data);

    log.d("result: $result");

    setBusy(false);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_judulService];
}
