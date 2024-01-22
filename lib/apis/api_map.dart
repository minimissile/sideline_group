class Api {
  // ---------------------- auth ----------------------

  /// 验证邮件验证码并激活账号
  static const verifyEmailCode = "/user/verifyEmailCode";

  /// 修改用户信息
  static const updateInfo = "/user/updateInfo";

  /// 注册
  static const registerForEmail = "/user/registerForEmail";

  /// 登录
  static const login = "/user/login";

  /// 接收邮件验证码
  static const getEmailCode = "/user/getEmailCode";

  // ---------------------- 聊天 ----------------------

  /// 发送消息
  static const sendMessage = "/person/sendMessage";
}
