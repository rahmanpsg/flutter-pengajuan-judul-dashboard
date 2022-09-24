import 'package:pengajuan_judul_dashboard/app/core/custom_base_service.dart';
import 'package:pengajuan_judul_dashboard/models/dosen_model.dart';

import '../app/app.logger.dart';

class DosenService extends CustomBaseService<DosenModel> {
  final log = getLogger("DosenService");

  DosenService()
      : super(
          collectionPath: 'dosens',
          orderBy: 'nama',
          fromJson: DosenModel.fromJson,
        );
}
