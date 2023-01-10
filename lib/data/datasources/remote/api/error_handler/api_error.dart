import 'dart:io';
import 'package:dio/dio.dart';

abstract class BaseException implements Exception {}

class NetworkException extends BaseException {
  final String type;

  NetworkException(this.type);

  @override
  String toString() => 'Network error: $type';
}

class ResponseException extends BaseException {
  final String type;

  ResponseException(this.type);

  @override
  String toString() => 'Response error: $type';
}

/// Handle Error
mixin ApiError {
  BaseException checkError(dynamic error) {
    if (error is Exception) {
      try {
        BaseException exception;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              exception = NetworkException('Request Cancelled');
              break;
            case DioErrorType.connectTimeout:
              exception = NetworkException('Connection request timeout');
              break;
            case DioErrorType.other:
              exception = NetworkException('No internet connection');
              break;
            case DioErrorType.receiveTimeout:
              exception = NetworkException('Send timeout in connection with API server');
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                case 401:
                case 403:
                  exception = ResponseException('Unauthorised request');
                  break;
                case 404:
                  exception = NetworkException('Not found');
                  break;
                case 409:
                  exception = NetworkException('Error due to a conflict');
                  break;
                case 408:
                  exception = NetworkException('Connection request timeout');
                  break;
                case 500:
                  exception = NetworkException('Internal Server Error');
                  break;
                case 503:
                  exception = NetworkException('Service unavailable');
                  break;
                default:
                  var responseCode = error.response!.statusCode;
                  exception = ResponseException("Received invalid status code: $responseCode");
              }
              break;
            case DioErrorType.sendTimeout:
              exception = NetworkException('Send timeout in connection with API server');
          }
        } else if (error is SocketException) {
          exception = NetworkException('No internet connection');
        } else {
          exception = NetworkException('Unexpected error occurred');
        }

        return exception;
      } on FormatException catch (_) {
        return NetworkException('Unexpected error occurred');
      } catch (_) {
        return NetworkException('Unexpected error occurred');
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkException('Unable to process the data');
      } else {
        return NetworkException('Unexpected error occurred');
      }
    }
  }
}
