import 'package:pengajuan_judul_dashboard/app/core/custom_base_service.dart';

import '../app/app.logger.dart';
import '../models/judul_model.dart';

class JudulService extends CustomBaseService<JudulModel> {
  final log = getLogger("JudulService");

  JudulService()
      : super(
          collectionPath: 'juduls',
          orderBy: 'createdAt',
          descending: true,
          fromJson: JudulModel.fromJson,
        );
}
