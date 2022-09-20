import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';

import '../app/core/custom_base_service.dart';

class MahasiswaService extends CustomBaseService<MahasiswaModel> {
  final log = getLogger("MahasiswaService");

  MahasiswaService()
      : super(
          collectionPath: 'mahasiswas',
          orderBy: 'name',
          fromJson: MahasiswaModel.fromJson,
        );
}
