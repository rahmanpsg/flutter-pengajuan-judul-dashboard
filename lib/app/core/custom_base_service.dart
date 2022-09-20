// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

import '../api/firestore_api.dart';
import '../app.logger.dart';

class CustomBaseService<T> with ReactiveServiceMixin {
  final _log = getLogger('CustomBaseService');

  late final String? _whereField;
  late final String? _whereValue;
  late final String? _orderBy;
  late final bool _descending;

  final FirestoreApi<T> firestoreApi = FirestoreApi<T>();
  final ReactiveList<T> _list = ReactiveList<T>();

  CustomBaseService({
    required String collectionPath,
    String? whereField,
    String? whereValue,
    String? orderBy,
    bool descending = false,
    required Function(Map<String, dynamic>) fromJson,
  })  : _whereField = whereField,
        _whereValue = whereValue,
        _orderBy = orderBy,
        _descending = descending {
    firestoreApi.collectionReference =
        FirebaseFirestore.instance.collection(collectionPath).withConverter<T>(
              fromFirestore: (snapshot, _) => fromJson(snapshot.data()!),
              toFirestore: (model, _) => (model as dynamic).toJson(),
            );

    listenToReactiveValues([_list]);
  }

  void syncData() async {
    if (_whereField != null && _whereValue != null) {
      firestoreApi.query = firestoreApi.collectionReference
          .where(_whereField!, isEqualTo: _whereValue);
    }

    if (_orderBy != null) {
      firestoreApi.query =
          firestoreApi.query?.orderBy(_orderBy!, descending: _descending);
    }

    final stream = firestoreApi.getCollectionStream();

    stream.listen(
      (result) async {
        for (var change in result.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              _list.insert(change.newIndex, change.doc.data() as T);
              break;
            case DocumentChangeType.modified:
              _list.removeAt(change.oldIndex);
              _list.insert(change.newIndex, change.doc.data() as T);
              break;
            case DocumentChangeType.removed:
              _list.remove(_list[change.oldIndex]);
              break;
            default:
          }
        }

        _log.i(
            "${firestoreApi.collectionReference.path} length : ${_list.length}");
      },
    );
  }

  T? get(String id) {
    return _list.firstWhereOrNull((dynamic list) => list.id == id);
  }

  Future save(T model) async {
    await firestoreApi.saveDocument(model);
  }

  Future delete(String id) async {
    await firestoreApi.deleteDocument(id);
  }

  Future dispose() async {
    _list.clear();
  }

  List<T> get list => _list;
}
