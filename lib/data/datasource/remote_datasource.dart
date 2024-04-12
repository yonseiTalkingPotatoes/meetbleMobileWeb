import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

/// Status Code
const ok = 200;
const invalidResponse = 100;
const noInternet = 101;
const invalidFormat = 102;
const unknownError = 103;

/// API URL
const meetble = "https://meetble.today";
const meetbleApi = "https://meetble.azurewebsites.net/api";

// Success to get response
class Success {
  final dynamic response;
  Success({required this.response});
}

// Fail to get response
class Failure {
  int code;
  String errorResponse;
  Failure({required this.code, required this.errorResponse});
}

// API communication
class RemoteDataSource {
  // Timeout Time is set on 5 seconds
  final int timeout = 5;

  // Get data from API by inputData
  Future<Object> getFromUri(String uri) async {
    try {
      final response = await Dio().get(uri, queryParameters: {}).timeout(
        const Duration(seconds: 600),
      );

      if (response.statusCode == ok) {
        return Success(response: response.data);
      }
      return Failure(code: invalidResponse, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: noInternet, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: unknownError, errorResponse: "Unknown Error");
    }
  }

  // Post inputData to database through API
  Future<Object> postToUri(String uri, Map<String, dynamic> inputData) async {
    try {
      Dio _dio = Dio();
      final response = await _dio
          .post(
            uri,
            data: jsonEncode(inputData),
          )
          .timeout(
            const Duration(seconds: 600),
          );

      if (response.statusCode == ok) {
        return Success(response: response.data);
      }
      return Failure(code: invalidResponse, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: noInternet, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: unknownError, errorResponse: "Unknown Error");
    }
  }

  // Edit data in database into inputData through API
  Future<Object> putToUri(String uri, Map<String, dynamic> inputData) async {
    try {
      final response = await Dio()
          .put(
            uri,
            data: inputData,
          )
          .timeout(
            const Duration(seconds: 600),
          );

      if (response.statusCode == ok) {
        return Success(response: response.data);
      }
      return Failure(code: invalidResponse, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: noInternet, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: unknownError, errorResponse: "Unknown Error");
    }
  }

  // Delete pointed to by the input data in the database through API
  Future<Object> deleteFromUri(
      String uri, Map<String, dynamic> inputData) async {
    try {
      final response =
          await Dio().delete(uri, queryParameters: inputData).timeout(
                const Duration(seconds: 600),
              );

      if (response.statusCode == ok) {
        return Success(response: response.data);
      }
      return Failure(code: invalidResponse, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: noInternet, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: unknownError, errorResponse: "Unknown Error");
    }
  }
}
