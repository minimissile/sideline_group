import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/core/polling_manager.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/model/user_model.dart';
import 'package:sideline_group/provider/app_provider.dart';
import 'package:sideline_group/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 用户鉴权相关
class AuthDao {
  /// 退出登录
  logout(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    userProvider.logout();
    appProvider.clearAccountData();
    PollingManager.getInstance().stopAllPolling();
  }

  /// 获取账户标识符
  getAccountHash() {
    var json = Cache.getInstance().getJSON(Storage.userProfile);
    UserModel userInfo = UserModel.fromJson(json);
    return userInfo.uid ?? 'test';
  }
}
