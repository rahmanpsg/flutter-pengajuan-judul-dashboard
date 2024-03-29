import 'package:pengajuan_judul_dashboard/app/app.dialog.dart';
import 'package:pengajuan_judul_dashboard/app/app.locator.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/enums/form_dialog_type.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/services/judul_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'widgets/judul_dialog/judul_dialog_view.dart';

class JudulViewModel extends ReactiveViewModel {
  final log = getLogger("JudulViewModel");

  final _dialogService = locator<DialogService>();
  final _judulService = locator<JudulService>();

  int tabIndexSelected = 0;

  bool isFiltered = false;

  final _filteredItems = <JudulModel>[];
  List<JudulModel> get _items => _judulService.list;

  List<JudulModel> get items =>
      isFiltered ? _filteredItems : _judulService.list;

  List<JudulModel> get listFilter => tabIndexSelected == 0
      ? items
      : items
          .where((x) =>
              x.status ==
              (tabIndexSelected == 1
                  ? null
                  : tabIndexSelected == 2
                      ? true
                      : false))
          .toList();

  int get total => _items.length;
  int get totalBelumDiverifikasi =>
      _items.where((x) => x.status == null).length;
  int get totalDiterima => _items.where((x) => x.status == true).length;
  int get totalDitolak => _items.where((x) => x.status == false).length;

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
          (item) => (item.judul!.toLowerCase().contains(value.toLowerCase())),
        )
        .toList();

    _filteredItems.addAll(filteredItems);

    log.d(_filteredItems);

    notifyListeners();
  }

  void setTabIndexSelected(int idx) {
    tabIndexSelected = idx;
    notifyListeners();
  }

  void openDetails(JudulModel judul) {
    _dialogService.showCustomDialog(
      variant: DialogType.judulDialogView,
      data: JudulDialogData(judul: judul),
    );
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

  void onDelete(JudulModel? judul) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Informasi',
      description: 'Anda yakin untuk menghapus data judul ${judul?.judul}?',
      dialogPlatform: DialogPlatform.Material,
    );

    if (response?.confirmed != true) return;

    final result = await _judulService.delete(judul!.id);

    log.d("result: $result");
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_judulService];
}
