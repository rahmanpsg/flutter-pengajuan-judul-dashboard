import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';

class FirebaseStorageApi {
  final log = getLogger("FirebaseStorageApi");

  final _firebaseStorage = FirebaseStorage.instance;

  Future<UploadTask?> uploadFile(String path, Uint8List fileData,
      [String? contentType]) async {
    log.d("path : $path");

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = _firebaseStorage.ref(path);

    final metadata = SettableMetadata(
      contentType: contentType,
    );

    if (kIsWeb) {
      uploadTask = ref.putData(fileData, metadata);
    } else {
      uploadTask = ref.putFile(File.fromRawPath(fileData), metadata);
    }

    return Future.value(uploadTask);
  }

  // delete file
  Future<void> deleteFile(String path) async {
    log.d("path : $path");

    try {
      await _firebaseStorage.ref(path).delete();
    } on FirebaseException catch (e) {
      log.e("error: ${e.toString()}");
    } catch (e) {
      log.e(e);
    }
  }
}
