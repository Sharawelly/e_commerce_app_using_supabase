import 'package:dio/dio.dart';
import 'package:e_commerce_app_using_supabase/core/sensitive_data.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dcjaykkfynunujgbbayp.supabase.co/rest/v1/',
      headers: {"apikey": SensitiveData.anonKey},
    ),
  );

  // ! path => endpoint
  Future<Response> getData(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    try {
      return await _dio.patch(path, data: data);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Response> deleteData(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
