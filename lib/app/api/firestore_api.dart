import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/api_response_model.dart';
import '../app.logger.dart';

class FirestoreApi<T> {
  final log = getLogger("FirestoreApi");

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// need to set [CollectionReference]  if you call this class
  ///
  ///example :
  /// ```dart
  ///firestoreApi.collectionReference = firebaseService.firebaseFirestore
  ///   .collection(collectionPath)
  ///   .withConverter<T>(
  ///     fromFirestore: (snapshot, _) => fromJson(snapshot.data()!),
  ///     toFirestore: (model, _) => (model as dynamic).toJson(),
  /// );
  /// ```
  late final CollectionReference<T> collectionReference;

  /// set this [query] if you want to filter data
  ///
  /// example :
  /// ```dart
  /// firestoreApi.query = firestoreApi.collectionReference.where('role', isNotEqualTo: 'Admin');
  /// ```
  Query<T>? query;

  Stream<QuerySnapshot<T>> getCollectionStream() {
    query ??= collectionReference;

    return query!.snapshots();
  }

  Future<ApiResponseModel<T>> getDocument(String documentId) async {
    log.d("path : ${collectionReference.path}");

    try {
      final response = await collectionReference.doc(documentId).get();

      log.d("response : ${response.data()}");

      return ApiResponseModel.success(data: response.data());
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ApiResponseModel.error(message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ApiResponseModel.error(message: e.toString());
    }
  }

  Future<ApiResponseModel<List<QueryDocumentSnapshot<T>>>>
      getDocuments() async {
    log.d("path : ${collectionReference.path}");

    log.d('T : $T');

    try {
      final response = await collectionReference.get();
      log.d("response length: ${response.docs.length}");

      return ApiResponseModel.success(
        data: response.docs,
      );
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ApiResponseModel.error(message: e.message ?? '');
    } catch (e) {
      log.e("error: ${e.toString()}");
      return ApiResponseModel.error(message: e.toString());
    }
  }

  /// Overwriting any existing data. If the document does not yet exist, it will be created.
  Future<ApiResponseModel> saveDocument(T data,
      {String? documentID, merge = true}) async {
    log.i("path : ${collectionReference.path}, data :$data");

    try {
      await _firebaseFirestore.runTransaction((Transaction transactionHandler) {
        return collectionReference
            .doc(documentID ?? (data as dynamic).id)
            .set(data, SetOptions(merge: merge));
      });

      log.i("saveDocument: success");
      return ApiResponseModel.success();
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ApiResponseModel.error(message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ApiResponseModel.error(message: e.toString());
    }
  }

  Future<ApiResponseModel> deleteDocument(String documentId) async {
    log.i("path : ${collectionReference.path}, documenId : $documentId,");
    try {
      await collectionReference.doc(documentId).delete();

      log.i("deleteDocument: success");
      return ApiResponseModel.success();
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
      return ApiResponseModel.error(message: e.message ?? '');
    } catch (e) {
      log.e(e);
      return ApiResponseModel.error(message: e.toString());
    }
  }
}
