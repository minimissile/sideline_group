import 'dart:async';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:flutter/material.dart';

/// 轮询任务枚举，用于管理后台轮询任务
enum PollingTask {
  /// 查询背景装饰生成状态（选择角色形象时有延时生成）
  ornament,

  /// 轮询查询当前首页、聊天背景图片(根据最新行程)
  appBackground,

  /// 背景渲染结果（查询是否渲染完，渲染完缓存到本地）
  backgroundRenderingResults,

  /// 轮询最新料条消息判读是Ai 是否有主动聊天
  activeChat,

  /// 轮询查询最新日记
  journal,
}

/// 轮询管理器
class PollingManager {
  static final PollingManager _instance = PollingManager._internal();
  late Map<PollingTask, PollingService> _pollingServices;

  static late BuildContext _appContext;

  factory PollingManager() {
    return _instance;
  }

  /// 获取实例
  static PollingManager getInstance() {
    return _instance;
  }

  PollingManager._internal() {
    _pollingServices = {};
  }

  /// 初始化上下文
  static void init(BuildContext appContext) {
    _appContext = appContext;
  }

  /// 开始轮询
  /// [taskName] 任务名称
  /// [interval] 轮询间隔
  /// [isRunNow] 是否立即执行
  /// [pollingLogic] 自定义轮询逻辑
  void startPolling(
      PollingTask taskName, Duration interval, bool isRunNow, Function(Map<String, dynamic>) pollingLogic) {
    // 检查是否已存在相同任务，避免重复添加
    if (!_pollingServices.containsKey(taskName)) {
      final pollingService = PollingService(taskName, interval, pollingLogic, isRunNow: isRunNow);
      _pollingServices[taskName] = pollingService;
      // pollingService.init(_appContext);
      pollingService.start();
    } else {
      Logger.log('当前启动的任务已存在： $taskName', title: "PollingManager");
    }
  }

  /// 停止轮询
  void stopPolling(PollingTask taskName) {
    Logger.log('通过管理器停止轮询任务： $taskName', title: "PollingManager");
    final pollingService = _pollingServices.remove(taskName);
    pollingService?.stop();
  }

  /// 停止所有轮询服务
  void stopAllPolling() {
    for (final pollingService in _pollingServices.values) {
      pollingService.stop();
    }
    _pollingServices.clear();
    Logger.log('所有轮询任务已停止', title: "PollingManager");
  }
}

/// 轮询服务
class PollingService {
  /// 任务名称
  final PollingTask taskName;

  /// 轮询间隔
  final Duration interval;

  /// 轮训逻辑是否在启动时立即执行一遍
  final bool isRunNow;

  /// 轮询逻辑
  final Function(Map<String, dynamic>) pollingLogic;

  /// 定时器
  late Timer _timer;

  /// 是否在运行
  late bool _isRunning;

  static late BuildContext _buildContext;

  PollingService(this.taskName, this.interval, this.pollingLogic, {this.isRunNow = true})
      : _isRunning = false,
        _timer = Timer(Duration.zero, () {});

  void init(BuildContext context) {
    // 在这里进行初始化操作
    // 可以保存BuildContext供后续使用
    _buildContext = context;
  }

  /// 检查运行状态
  bool isRunning() {
    return _isRunning;
  }

  /// 开始轮询
  void start() {
    if (_isRunning) {
      return;
    }

    _isRunning = true;
    _timer.cancel();

    // 是否立即执行
    if (isRunNow) {
      pollingLogic({'taskName': taskName});
    }

    _timer = Timer.periodic(interval, (timer) {
      Logger.log('正在执行轮询任务： $taskName', title: "PollingService");
      try {
        pollingLogic({'taskName': taskName});
      } catch (e) {
        Logger.log('任务的轮询逻辑出错 $taskName: $e', title: "PollingService");
      }
    });
  }

  /// 停止轮询
  void stop() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
      Logger.log('轮询任务：$taskName 已停止', title: "PollingService");
    }
  }
}
