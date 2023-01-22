import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/enums/form_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/services/dosen_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/daftar_bimbingan_dialog/daftar_bimbingan_dialog_view.dart';
import 'package:pengajuan_judul_dashboard/ui/views/dosen/form_dosen_dialog/form_dosen_dialog_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/dosen_model.dart';

class DosenViewModel extends ReactiveViewModel {
  final log = getLogger("DosenViewModel");

  final _dialogService = locator<DialogService>();
  final _dosenService = locator<DosenService>();

  bool isFiltered = false;

  final _filteredItems = <DosenModel>[];
  List<DosenModel> get _items => _dosenService.list;

  List<DosenModel> get items =>
      isFiltered ? _filteredItems : _dosenService.list;

  Future<void> init() async {}

  void onSearch(String value) {
    isFiltered = false;
    _filteredItems.clear();

    if (value.isEmpty) {
      notifyListeners();
      return;
    }

    isFiltered = true;
    final filteredItems = _items
        .where(
          (item) => (item.nama!.toLowerCase().contains(value.toLowerCase()) ||
              (item.nbm?.toLowerCase().contains(value.toLowerCase()) ?? false)),
        )
        .toList();

    _filteredItems.addAll(filteredItems);

    log.d(_filteredItems);

    notifyListeners();
  }

  void openDetails(DosenModel dosen) {
    _dialogService.showCustomDialog(
      variant: DialogType.daftarBimbinganDialogView,
      data: DaftarBimbinganDialogData(dosen: dosen),
    );
  }

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
