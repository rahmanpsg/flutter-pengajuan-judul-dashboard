import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
import 'package:stacked/stacked.dart';

import '../app/api/firestore_api.dart';

class MahasiswaService with ReactiveServiceMixin {
  MahasiswaService() {
    listenToReactiveValues([_mahasiswas]);
  }

  final log = getLogger("MahasiswaService");

  final _firestoreApi = FirestoreApi<MahasiswaModel>()
    ..collectionReference = FirebaseFirestore.instance
        .collection('jurnals')
        .withConverter<MahasiswaModel>(
          fromFirestore: (snapshot, _) =>
              MahasiswaModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

  final ReactiveList<MahasiswaModel> _mahasiswas =
      ReactiveList<MahasiswaModel>();

  void syncData() async {}

  List<MahasiswaModel> get mahasiswas => _mahasiswas;
}
