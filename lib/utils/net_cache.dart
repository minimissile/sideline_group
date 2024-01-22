import 'package:sideline_group/config/index.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:dio/dio.dart';
import 'dart:collection';

class CacheObject {
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!CACHE_ENABLE) {
      handler.next(options);
    }

    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    // 是否磁盘缓存
    bool cacheDisk = options.extra["cacheDisk"] == true;

    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["isList"] == true) {
        // 若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }

      // 删除磁盘缓存
      if (cacheDisk) {
        Cache.getInstance().remove(options.uri.toString());
      }

      handler.next(options);
    }

    // 开启缓存
    if (options.extra["useCache"] == true) {
      String key = options.extra["cacheKey"] ?? options.uri.toString();



      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];

      Logger.log('需要从缓存中获取数据: $ob', title: 'NetCache');

      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 < CACHE_MAXAGE) {
          // return cache[key].response;
          handler.next(cache[key]?.response as RequestOptions);
          // todo: 返回数据待验证
          // handler.resolve(cache[key]!.response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = Cache.getInstance().get(key);
        if (cacheData != null) {
          // 如果需要，对选项进行修改
          Response response = Response(requestOptions: options, data: cacheData, statusCode: 200);
          handler.resolve(response);
        }
      }
    }
    handler.next(options);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    // 错误状态不缓存
    handler.next(err);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (CACHE_ENABLE) {
      await _saveCache(response, handler);
    }
    handler.resolve(response);
  }

  Future<void> _saveCache(Response object, ResponseInterceptorHandler handler) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["useCache"] == true && options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await Cache.getInstance().setJSON(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
