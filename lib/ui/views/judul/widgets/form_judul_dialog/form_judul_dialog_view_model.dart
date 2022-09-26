import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/api/firebase_storage_api.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/app/core/custom_base_view_model.dart';
import 'package:pengajuan_judul_dashboard/models/file_data_model.dart';
import 'package:pengajuan_judul_dashboard/models/judul_model.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:pengajuan_judul_dashboard/services/mahasiswa_service.dart';
import 'package:pengajuan_judul_dashboard/ui/views/judul/widgets/form_judul_dialog/form_judul_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../enums/form_dialog_type.dart';

class FormJudulDialogViewModel extends CustomBaseViewModel {
  final log = getLogger("FormJudulDialogViewModel");

  final _firebaseStorage = locator<FirebaseStorageApi>();

  final formKey = GlobalKey<FormState>();

  late final Function(DialogResponse) completer;

  late final FormDialogType type;
  late final JudulModel judul;

  List<MahasiswaModel> get mahasiswas => locator<MahasiswaService>().list;

  FileDataModel? fileData;

  Future<void> init(
      Function(DialogResponse) completer, FormJudulDialogData data) async {
    this.completer = completer;
    type = data.type;
    judul = data.judul ?? JudulModel(status: true);

    log.d(judul);
  }

  void openFilePicker(TextEditingController controller) async {
    final response = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx'],
    );

    log.d("response: $response");

    if (response == null) return;

    final file = response.files.first;

    fileData = FileDataModel(
      name: file.name,
      bytes: file.size,
      data: file.bytes,
    );

    log.d(fileData);
    log.d("data: ${fileData?.data}");

    controller.text = "${fileData?.name} (${fileData?.size})";
  }

  void onCancel() async {
    completer(
      DialogResponse(
        confirmed: false,
      ),
    );
  }

  void onSubmit() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    if (fileData != null) {
      final uploadTask = await _firebaseStorage.uploadFile(
        "juduls/${judul.id}_${fileData?.name}",
        fileData!.data!,
      );

      if (uploadTask == null) return;

      log.d("Uploading file...");

      uploadTask.then((ts) async {
        log.d("Uploading file success");

        final url = await ts.ref.getDownloadURL();

        log.i(url);

        fileData?.url = url;

        judul.fileData = fileData;
      }).catchError((e) {
        log.e(e);

        dialogService.showDialog(
          title: 'Informasi',
          description: 'Terjadi masalah, silahkan coba kembali!',
          dialogPlatform: DialogPlatform.Material,
        );
      }).whenComplete(() {
        completer(
          DialogResponse(
            confirmed: true,
            data: judul,
          ),
        );

        setBusy(false);
      });
      return;
    }

    completer(
      DialogResponse(
        confirmed: true,
        data: judul,
      ),
    );
  }
}
