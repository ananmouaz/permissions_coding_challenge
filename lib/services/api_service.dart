import 'package:dio/dio.dart';
import '../models/consent_model.dart';

enum ApiResult { success, failure }

class ApiService {
  final Dio _dio;
  // This is a stub API URL, replace with actual URL in a real app
  final String _apiUrl = 'https://fake-api.example.com/consent';

  ApiService() : _dio = Dio() {
    // Configure Dio if needed
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<ApiResult> sendConsentData(ConsentModel consent) async {
    try {
      final response = await _dio.post(
        _apiUrl,
        data: consent.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // For demo purposes, we'll consider status codes in 200s as success
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ApiResult.success;
      } else {
        return ApiResult.failure;
      }
    } catch (e) {
      print('Error sending consent data: $e');
      return ApiResult.failure;
    }
  }

  // For demo purposes, this method simulates API success
  Future<ApiResult> simulateSuccess() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return ApiResult.success;
  }

  // For demo purposes, this method simulates API failure
  Future<ApiResult> simulateFailure() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return ApiResult.failure;
  }
}