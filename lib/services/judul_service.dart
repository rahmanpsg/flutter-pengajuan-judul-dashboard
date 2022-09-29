import 'package:pengajuan_judul_dashboard/app/core/custom_base_service.dart';
import 'package:pengajuan_judul_dashboard/models/api_response_model.dart';
import 'package:pengajuan_judul_dashboard/models/hasil_deteksi_model/hasil_deteksi_model.dart';

import '../app/api/api.dart';
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

  final _api = Api();

  Future<List<HasilDeteksiModel>> deteksi(JudulModel judul, [int K = 3]) async {
    final response = await _api.post('proses', {
      'text': judul.judul,
      'k': K,
    });

    if (response.error) {
      throw response;
    }

    List<HasilDeteksiModel> hasils = [];

    for (var hasil in response.data) {
      hasils.add(HasilDeteksiModel.fromJson(hasil));
    }

    return hasils;
  }
}
