import 'dart:io';

import 'package:cinefouine/data/sources/dio_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(
  DioClientRef ref, {
  required String url,
  Dio? client,
  List<Interceptor>? interceptors,
}) {
  return DioClient(
    url: url,
    client: client,
    interceptors: interceptors,
  );
}

class DioClient {
  DioClient({
    required String url,
    Dio? client,
    List<Interceptor>? interceptors,
  })  : _url = url,
        _client = client ?? Dio(),
        _interceptors = interceptors {
    _createDioInstance();
  }

  final String _url;
  final Dio _client;
  final List<Interceptor>? _interceptors;

  void _createDioInstance() {
    _client.options.baseUrl = baseUrl;
    //_client.interceptors.clear(); if need to clear dio instance interceptors
    // Désactive la vérification des certificats SSL

    if (_interceptors != null) {
      _client.interceptors.addAll(_interceptors);
    }
  }

  String get baseUrl => _url;

  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    T Function(Object)? deserializer,
  }) async {
    try {
      final response = await _client.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          deserializer != null) {
        final Object json = response.data as Object;
        return deserializer(json);
      } else {
        return null;
      }
    } on DioException catch (e) {
      final errorMessage = AppDioExceptions.fromDioError(e);
      throw errorMessage;
    }
  }

  Future<T?> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Object)? deserializer,
  }) async {
    try {
      print("Test post !!");
      final response = await _client.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          deserializer != null) {
        final Object json = response.data as Object;
        return deserializer(json);
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.type);
      final errorMessage = AppDioExceptions.fromDioError(e);
      throw errorMessage;
    }
  }

  Future<T?> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Object)? deserializer,
  }) async {
    try {
      final response = await _client.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          deserializer != null) {
        final Object json = response.data as Object;
        return deserializer(json);
      } else {
        return null;
      }
    } on DioException catch (e) {
      final errorMessage = AppDioExceptions.fromDioError(e);
      throw errorMessage;
    }
  }

  Future<T?> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Object)? deserializer,
  }) async {
    try {
      final response = await _client.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          deserializer != null) {
        final Object json = response.data as Object;
        return deserializer(json);
      } else {
        return null;
      }
    } on DioException catch (e) {
      final errorMessage = AppDioExceptions.fromDioError(e);
      throw errorMessage;
    }
  }

  Future<dynamic> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Object)? deserializer,
  }) async {
    try {
      final response = await _client.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      print("DEBUG DioClient: delete response: $response");
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          deserializer != null) {
        final Object json = response.data as Object;
        return deserializer(json);
      } else {
        return null;
      }
    } on DioException catch (e) {
      final errorMessage = AppDioExceptions.fromDioError(e);
      throw errorMessage;
    }
  }

  Future<Response<dynamic>> request(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _client.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioException {
      rethrow;
    }
  }
}
