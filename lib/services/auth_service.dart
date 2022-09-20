import 'package:firebase_auth/firebase_auth.dart';
import 'package:pengajuan_judul_dashboard/app/app.logger.dart';
import 'package:pengajuan_judul_dashboard/models/api_response_model.dart';

class AuthService {
  final log = getLogger("AuthService");

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<ApiResponseModel<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return ApiResponseModel.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log.e(e);

      return ApiResponseModel.error(
          message: e.message ?? 'Terjadi masalah yang tidak diketahui');
    } on Exception catch (e) {
      log.e(e);

      return const ApiResponseModel.error(
          message: 'Terjadi masalah yang tidak diketahui');
    }
  }

  Future logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log.e(e);
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isLoggedIn => _firebaseAuth.currentUser != null;
}
