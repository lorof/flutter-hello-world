import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/config.dart';
import 'package:my_app/injectable_init.dart';

final String? apiUrl = getIt<Config>().apiUrl;

const String ERROR_MESSAGE = 'API_URL is not specified';

BaseOptions getOptions() {
  if (apiUrl == null) {
    throw Exception(ERROR_MESSAGE);
  }

  return BaseOptions(
    baseUrl: apiUrl !,
  );
}

@singleton
class HttpClient {
  Dio _client = Dio(getOptions());

  Config _config = getIt<Config>();

  HttpClient() {
    _client.interceptors.add(_interceptor());
  }

  Interceptor _interceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final String? clientId = _config.clientId;
        final String? clientSecret = _config.clientSecret;

        options.queryParameters = {
          ...options.queryParameters,
          'client_id': clientId,
          'client_secret': clientSecret
        };

        return handler.next(options);
      },
    );
  }

  Future<Response> get<T>(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) {
    return _client.get<T>(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response> post<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client.post<T>(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);

  Future<Response> put<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _client.put<T>(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

  Future<Response> delete<T>(String url,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Options? options,
          CancelToken? cancelToken}) =>
      _client.delete<T>(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
}
