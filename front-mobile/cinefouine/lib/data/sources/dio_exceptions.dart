import 'dart:io';

import 'package:dio/dio.dart';

class AppDioExceptions implements Exception {
  AppDioExceptions.set({
    required AppDioExceptionType typeToSet,
    required String messageToSet,
  }) {
    type = typeToSet;
    message = messageToSet;
  }

  AppDioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        type = AppDioExceptionType.cancel;
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        type = AppDioExceptionType.connectionTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        type = AppDioExceptionType.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        final (messageValue, typeValue) = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        message = messageValue;
        type = typeValue;
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        type = AppDioExceptionType.sendTimeout;
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        type = AppDioExceptionType.badCertificate;
        break;
      case DioExceptionType.connectionError:
        message = 'No Internet';
        type = AppDioExceptionType.connectionError;
        break;
      case DioExceptionType.unknown:
        message = 'Unknown error occurred';
        type = AppDioExceptionType.unknown;
        break;
      default:
        message = 'Something went wrong';
        type = AppDioExceptionType.unknown;
        break;
    }
  }

  late String message;
  late AppDioExceptionType type;

  (String, AppDioExceptionType) _handleError(int? statusCode, dynamic error) =>
      switch (statusCode) {
        HttpStatus.badRequest => (
            'Bad request',
            AppDioExceptionType.badRequest,
          ),
        HttpStatus.unauthorized => (
            'Unauthorized',
            AppDioExceptionType.unauthorized,
          ),
        HttpStatus.forbidden => (
            'Forbidden',
            AppDioExceptionType.forbidden,
          ),
        HttpStatus.notFound => (
            'Not found',
            AppDioExceptionType.notFound,
          ),
        HttpStatus.internalServerError => (
            'Internal server error',
            AppDioExceptionType.internalServerError,
          ),
        HttpStatus.badGateway => (
            'Bad gateway',
            AppDioExceptionType.badGateway,
          ),
        _ => (
            'Oops something went wrong',
            AppDioExceptionType.unknownStatusCode
          ),
      };

  @override
  String toString() => message;
}

enum AppDioExceptionType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// The [DioException] was caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badRequest,

  unauthorized,

  forbidden,

  notFound,

  internalServerError,

  badGateway,

  unknownStatusCode,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  //when user has no team
  noTeam,

  /// Default error type, Some other [Error]. In this case, you can use the
  /// [DioExcetion.error] if it is not null.
  unknown,
}