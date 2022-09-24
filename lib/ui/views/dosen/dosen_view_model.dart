import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/enums/form_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/services/dosen_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/widgets/form_dosen_dialog/form_dosen_dialog_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/dosen_model.dart';

class DosenViewModel extends ReactiveViewModel {
  final log = getLogger("DosenViewModel");

  final _dialogService = locator<DialogService>();
  final _dosenService = locator<DosenService>();

  List<DosenModel> get list => _dosenService.list;

  Future<void> init() async {}

  void onAddOrEdit(DosenModel? dosen) async {
    bool isEdit = dosen != null;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.formDosenDialogView,
      data: FormDosenDialogData(
        type: isEdit ? FormDialogType.edit : FormDialogType.add,
        dosen: dosen,
      ),
      title: '${isEdit ? 'Edit' : 'Tambah'} Data Dosen',
    );

    log.d("response: ${response?.data}");

    if (response?.confirmed != true) return;

    setBusy(true);

    final result = await _dosenService.save(response!.data);

    log.d("result: $result");

    setBusy(false);
  }

  void onDelete(DosenModel dosen) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Informasi',
      description: 'Anda yakin untuk menghapus data dosen ${dosen.nama}?',
      dialogPlatform: DialogPlatform.Material,
    );

    if (response?.confirmed != true) return;

    final result = await _dosenService.delete(dosen.id);

    log.d("result: $result");
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dosenService];
}
