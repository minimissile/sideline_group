import 'dart:async';
import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/dao/auth_dao.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/model/user_model.dart';
import 'package:sideline_group/utils/i10n.dart';
import 'package:sideline_group/utils/navigator_util.dart';
import 'package:flutter/material.dart';
import 'logger_util.dart';

/// 登录权限工具类
class AuthUtil {
  /// 重新登录
  static anewLogin(BuildContext context) {
    Logger.log('重新登录0 $context', title: 'AuthUtil');
    AuthDao().logout(context);
    Logger.log('重新登录1', title: 'AuthUtil');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 添加圆角
          ),
          title: const Text(
            "请重新登录",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: const Text(
                "确认",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                // 执行重新登录操作
                NavigatorUtil.logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// 缓存账号
  static cacheAccounts(UserLoginRequestModel params) {
    Logger.log('缓存账号 ${params.toJson()}', title: 'Login');
    // Cache.getInstance().setString(STORAGE_LOGIN_EMAIL, params.email);
    // Cache.getInstance().setString(STORAGE_PASSWORLD, params.password);
  }

  /// 删除缓存 token
  Future deleteAuthentication() async {
    await Cache.getInstance().remove(Storage.userProfile);
  }

  /// 检查是否有 token
  Future<bool> isAuthenticated() async {
    var profileJSON = Cache.getInstance().get(Storage.userProfile);
    return profileJSON != null ? true : false;
  }
}
