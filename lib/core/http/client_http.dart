import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mybookstore/core/errors/exceptions.dart';
import 'package:mybookstore/core/http/app_interceptor.dart';

enum HttpMethod { get, post, put, patch, delete }

abstract class IClientHttp {
  Future<HttpResponse> request(HttpMethod method, String path, {Map<String, dynamic>? queryParameters, dynamic data});
  void addInterceptor(Interceptor interceptor);
}

class ClientHttp implements IClientHttp {
  ClientHttp({required String baseUrl, required Dio client})
      : _baseUrl = baseUrl,
        _dio = client {
    _configureDio(_baseUrl);
  }

  final String _baseUrl;
  final Dio _dio;

  void _configureDio(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = 'application/json; charset=utf-8';
    _dio.options.connectTimeout = Duration(seconds: 15);
    _dio.options.receiveTimeout = Duration(seconds: 15);
    addInterceptor(AppInterceptor());
  }

  @override
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  Future<HttpResponse> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();
      log('${response.statusCode} - ${response.statusMessage}', name: 'Response');
      log(response.data.toString(), name: 'Response');
      return HttpResponse(data: response.data, statusCode: response.statusCode, message: response.statusMessage);
    } on DioException catch (e) {
      throw ServerException(statusCode: e.response?.statusCode ?? 500, message: _handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    log('${method.name.toUpperCase()} - $_baseUrl$path', name: 'Request');
    log(data.toString(), name: 'Request');
    return _handleRequest(() {
      switch (method) {
        case HttpMethod.get:
          return _dio.get(path, queryParameters: queryParameters);
        case HttpMethod.post:
          return _dio.post(path, queryParameters: queryParameters, data: data);
        case HttpMethod.put:
          return _dio.put(path, queryParameters: queryParameters, data: data);
        case HttpMethod.patch:
          return _dio.patch(path, queryParameters: queryParameters, data: data);
        case HttpMethod.delete:
          return _dio.delete(path, queryParameters: queryParameters, data: data);
      }
    });
  }

  String _handleDioError(DioException e) {
    final message = _handleDioMessage(e);
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tempo limite de conexão excedido!';
      case DioExceptionType.receiveTimeout:
        return 'Tempo limite de resposta excedido!';
      case DioExceptionType.sendTimeout:
        return 'Tempo limite de envio excedido!';
      case DioExceptionType.badResponse:
        return 'Erro na resposta: $message';
      case DioExceptionType.cancel:
        return 'Requisição cancelada $message';
      case DioExceptionType.connectionError:
        return 'Falha de conexão com o servidor: $message';
      default:
        return e.message ?? message;
    }
  }

  String _handleDioMessage(DioException e) {
    if (e.message != null && e.message!.isNotEmpty) {
      return e.message!;
    }
    final source = (e.error as dynamic)?.source;
    if (source is List<int>) {
      try {
        final message = utf8.decode(source);
        return message;
      } catch (_) {
        return '';
      }
    }
    final messageError = (e.error as dynamic)?.message;
    if (messageError is String) {
      try {
        final message = utf8.decode(source);
        return message;
      } catch (_) {
        return '';
      }
    }
    return '';
  }
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;
  final String? message;

  HttpResponse({required this.data, this.statusCode, this.message});
}
