import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:sideline_group/apis/api_map.dart';
import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/utils/net_cache.dart';
import 'package:sideline_group/config/index.dart';
import 'package:sideline_group/utils/toast_util.dart';
import 'package:sideline_group/utils/auth_util.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// 客户端请求类
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late Dio _dio;

  CancelToken cancelToken = CancelToken();

  static late BuildContext _context;

  /// 是否打印请求信息
  bool showLog = false;

  static ApiClient getInstance() {
    return _instance;
  }

  /// 初始化上下文
  static void init(BuildContext context) async {
    _context = context;
  }

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: SERVER_API_URL,
      responseType: ResponseType.json,
      // 链接超时时间
      connectTimeout: const Duration(seconds: 600),
      // 接收超时时间
      receiveTimeout: const Duration(seconds: 600),
    );

    _dio = Dio(options);

    // LogInterceptor 是 Dio 提供的一个拦截器，用于记录请求和响应的日志。
    // requestBody: true 表示要在日志中显示请求的请求体（即请求参数）。
    // responseBody: true 表示要在日志中显示响应的响应体（即服务器返回的数据）。
    // _dio.interceptors.add(LogInterceptor(
    //   requestBody: showLog,
    //   responseBody: showLog,
    //   request: showLog,
    //   requestHeader: showLog,
    //   responseHeader: showLog,
    // ));

    // 打印信息美化
    _dio.interceptors.add(PrettyDioLogger(
      request: false,
      requestHeader: showLog,
      requestBody: showLog,
      responseBody: showLog,
      responseHeader: showLog,
      error: showLog,
      compact: false,
    ));

    // 添加拦截器来处理错误
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // 在这里处理响应数据
        if (response.statusCode == 200) {
          var code = response.data['code'];

          print('code: $code ${code.runtimeType}');

          if (code != 200) {
            response.requestOptions.path;
            var requestOptions = response.requestOptions;
            Logger.log("当前请求异常：${requestOptions.baseUrl}/${requestOptions.path}", title: 'ApiClient');
          }

          switch (code) {
            case 403: // 重新登录
              if (_context.mounted) {
                AuthUtil.anewLogin(_context);
              }
              break;
            default:
              break;
          }
        } else {
          // 处理其他响应状态码
          Logger.log('Response Error: ${response.statusCode}');
        }

        handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        Logger.log('请求出错 $error', title: 'ApiClient');

        if (error.response == null) {
          // 如果是服务端未能响应的异常，取消请求
          Toast.show("服务器无响应");
          // cancelRequests(cancelToken);
        } else {
          // 处理其他错误逻辑
          // 错误提示
          ErrorEntity eInfo = createErrorEntity(error);
          Toast.show(eInfo.message ?? '');
        }

        Logger.log('api错误拦截 执行返回操作', title: 'ApiClient');
        handler.next(error);
      },
    ));

    // 添加缓存拦截器
    _dio.interceptors.add(NetCache());
  }

  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    Map<String, dynamic> headers;
    String accessToken = Cache.getInstance().get(Storage.accessToken) ?? "";
    headers = {
      'Cookie': accessToken,
    };
    return headers;
  }

  /// 取消请求
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
    _dio.httpClientAdapter.close(force: true);
  }

  /// 错误信息统一处理
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request cancellation"); // 请求取消
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: "Connection timed out"); // 连接超时
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: "The request timed out"); // 请求超时
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: "The Response timed out"); // 响应超时
      case DioExceptionType.badResponse:
        {
          // 由配置的错误代码导致的报错
          try {
            int? errCode = error.response?.statusCode;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                return ErrorEntity(code: errCode, message: error.response?.statusMessage);
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        return ErrorEntity(code: -1, message: error.message);
    }
  }

  /// get请求
  /// hasCache: 是否需要缓存
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    bool? useCache = false,
    bool? refresh = false,
    String? cacheKey,
    bool? cacheDisk = false,
    bool? isList = false,
    bool useAuthorization = false,
  }) async {
    Options requestOptions = options ?? Options();

    requestOptions.extra = {
      'useCache': useCache,
      "refresh": refresh,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
      "isList": isList,
    };

    try {
      var response = await _dio.get(
        path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException {
      rethrow;
    }
  }

  /// post请求
  /// [useAuthorization]: 是否需要登录权限
  /// [useCache]: 是否缓存接口数据
  /// [cacheKey]: 缓存时作为key的值
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useAuthorization = false,
    bool? useCache = false,
    bool? refresh = false,
    String? cacheKey,
    bool? cacheDisk = false,
    bool? isList = false,
    CancelToken? cancelToken, // 新增
    String? contentType = 'multipart/form-data; boundary=----WebKitFormBoundaryIqPjEiI74bGlgUQP',
  }) async {
    // 添加额外的参数
    Options requestOptions = options ??
        Options(
          contentType: contentType,
          headers: {
            'Cookie': (useAuthorization == true ? Cache.getInstance().get(Storage.accessToken) : ''),
          },
        );

    requestOptions.extra = {
      'useCache': useCache,
      "refresh": refresh,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
      "isList": isList,
    };

    try {
      var response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: requestOptions,
        cancelToken: cancelToken ?? this.cancelToken,
      );

      // 如果是登录接口，拦截cookies并保存到本地
      if ((path == Api.login) && response.data['code'] == 200) {
        final cookie = response.headers['set-cookie']![0];
        RegExp regExp = RegExp(r'SESSION=[^;]+');

        RegExpMatch? match = regExp.firstMatch(cookie);

        if (match != null) {
          String session = match.group(0)!;
          Cache.getInstance().setString(Storage.accessToken, session);
        } else {
          Logger.log('没有找到SESSION', title: 'api_client');
        }
      }

      return response.data;
    } on DioException catch (e) {
      Logger.log('错误拦截DioException $e', title: 'ApiClient');
      rethrow;
    } catch (e) {
      Logger.log('错误拦截catch $e', title: 'ApiClient');
      rethrow;
    }
  }
}

/// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? message;

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
