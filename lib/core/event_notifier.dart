import 'dart:async';
import 'package:sideline_group/utils/logger_util.dart';

/// 事件通知管理类
class EventNotifier {
  /// 单例实例
  static final EventNotifier _instance = EventNotifier._internal();

  factory EventNotifier() => _instance;

  /// 私有构造函数，确保只能在类内部实例化
  EventNotifier._internal();

  /// 控制器
  final _controller = StreamController<EventData>.broadcast();

  /// 通知事件
  void notifyEvent(EventName eventName, dynamic data) {
    Logger.log('消息通知 notifyEvent： $data', title: 'EventNotifier');
    _controller.add(EventData(eventName, data));
  }

  /// 获取实例
  static EventNotifier getInstance() {
    return _instance;
  }

  /// 监听事件
  Stream<EventData> get onEvent => _controller.stream;

  /// 关闭 StreamController
  void dispose() {
    _controller.close();
    _latestEvent = null; // 清空缓存的最新事件
  }

  /// 添加监听者并返回 StreamSubscription 对象
  StreamSubscription addListener(
    EventName eventName,
    void Function(dynamic event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    Logger.log('消息通知 addListener： $eventName', title: 'EventNotifier');
    return onEvent.where((eventData) => eventData.eventName == eventName).map((eventData) => eventData.data).listen(
      onData,
      onDone: onDone,
      cancelOnError: cancelOnError,
      onError: (error) {
        Logger.log('消息通知 addListener Error： $error', title: 'EventNotifier');
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

  /// 多订阅者支持
  List<StreamSubscription> addMultipleListeners(
    List<EventName> eventNames,
    void Function(dynamic event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return eventNames
        .map(
          (eventName) => addListener(
            eventName,
            onData,
            onDone: onDone,
            cancelOnError: cancelOnError,
            onError: (error) {
              Logger.log('消息通知 addListener Error： $error', title: 'EventNotifier');
              if (onError != null) {
                onError(error);
              }
            },
          ),
        )
        .toList();
  }

  /// 取消监听
  void removeListener(StreamSubscription<Map<String, dynamic>> subscription) {
    Logger.log('消息通知 removeListener： $subscription', title: 'EventNotifier');
    subscription.cancel();
  }

  /// 事件过滤器
  Stream<EventData> filteredEvents(EventName eventName) {
    return onEvent.where((eventData) => eventData.eventName == eventName);
  }

  /// 性能优化，缓存最新事件
  dynamic _latestEvent;

  /// 获取最新的事件
  dynamic get latestEvent => _latestEvent;

  /// 添加监听者并返回 StreamSubscription 对象，同时缓存最新事件
  StreamSubscription addListenerWithLatest(
    EventName eventName,
    void Function(dynamic event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    var subscription = addListener(eventName, onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

    // 更新最新事件
    subscription.onData((event) {
      _latestEvent = event;
    });

    return subscription;
  }
}

/// 事件通知事件名
enum EventName { chatMessage }

/// 数据类，封装事件名和传输数据
class EventData {
  final EventName eventName;
  final dynamic data;

  EventData(this.eventName, this.data);
}
