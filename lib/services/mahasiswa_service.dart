import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';

import '../app/core/custom_base_service.dart';

class MahasiswaService extends CustomBaseService<MahasiswaModel> {
  final log = getLogger("MahasiswaService");

  MahasiswaService()
      : super(
          collectionPath: 'mahasiswas',
          orderBy: 'nama',
          fromJson: MahasiswaModel.fromJson,
        );
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pengajuan_judul_dashboard/models/api_response_model.dart';
// import 'package:pengajuan_judul_dashboard/models/mahasiswa_model.dart';
// import 'package:stacked/stacked.dart';

// import '../app/api/firestore_api.dart';
// import '../app/app.logger.dart';

// class MahasiswaService with ReactiveServiceMixin {
//   MahasiswaService() {
//     listenToReactiveValues([_list]);
//   }

//   final log = getLogger("MahasiswaService");

//   final _firestoreApi = FirestoreApi<MahasiswaModel>()
//     ..collectionReference = FirebaseFirestore.instance
//         .collection('mahasiswas')
//         .withConverter<MahasiswaModel>(
//           fromFirestore: (snapshot, _) =>
//               MahasiswaModel.fromJson(snapshot.data()!),
//           toFirestore: (model, _) => model.toJson(),
//         );

//   final ReactiveList<MahasiswaModel> _list = ReactiveList<MahasiswaModel>();

//   void syncData() async {
//     try {
//       final response = await _firestoreApi.getDocuments();

//       if (response.error) return;

//       _list.clear();

//       for (var mhs
//           in response.data as List<QueryDocumentSnapshot<MahasiswaModel>>) {
//         log.d("mhs: $mhs");
//         _list.add(mhs.data());
//       }
//     } catch (e) {
//       log.e(e);
//     }
//   }

//   Future<ApiResponseModel> add(MahasiswaModel mahasiswa) async {
//     await _firestoreApi.saveDocument(mahasiswa);

//     return ApiResponseModel.success();
//   }

//   Future<ApiResponseModel> edit(MahasiswaModel mahasiswa) async {
//     return await _firestoreApi.saveDocument(mahasiswa, merge: true);
//   }

//   Future<ApiResponseModel> delete(MahasiswaModel mahasiswa) async {
//     final response = await _firestoreApi.deleteDocument(mahasiswa.id!);

//     final idx = _list.indexOf(mahasiswa);

//     log.d("idx: $idx");

//     if (!response.error) {
//       _list.remove(mahasiswa);
//     }

//     return response;
//   }

//   List<MahasiswaModel> get list => _list;
// }
