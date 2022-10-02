import 'package:dio/dio.dart';
import 'package:pengajuan_judul_dashboard/models/api_response_model.dart';

import '../app.logger.dart';

class Api {
  static final Dio _dio = Dio(BaseOptions(
    // baseUrl: 'http://127.0.0.1:8000/api/',
    baseUrl: 'https://pengajuan-judul-server.herokuapp.com/api/',
  ));

  final log = getLogger('Api');

  Future<ApiResponseModel> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      return ApiResponseModel.success(data: response.data);
    } on DioError catch (e) {
      log.e(e);
      if (e.type == DioErrorType.response) {
        return ApiResponseModel.error(message: e.message);
      }

      return ApiResponseModel.error(
        message: 'Terjadi masalah yang tidak diketahui',
      );
    } catch (e) {
      log.e(e);
      return ApiResponseModel.error(
        message: 'Terjadi masalah yang tidak diketahui',
      );
    }
  }

  Future<ApiResponseModel> post(String endpoint, dynamic body) async {
    try {
      final response = await _dio.post(endpoint, data: body);

      return ApiResponseModel.success(data: response.data);
    } on DioError catch (e) {
      log.e(e);
      if (e.type == DioErrorType.response) {
        return ApiResponseModel.error(message: e.message);
      }

      return ApiResponseModel.error(
        message: 'Terjadi masalah yang tidak diketahui',
      );
    } catch (e) {
      log.e(e);
      return ApiResponseModel.error(
        message: 'Terjadi masalah yang tidak diketahui',
      );
    }
  }
}
