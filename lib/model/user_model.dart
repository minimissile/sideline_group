/// 用户模型类
class UserModel {
  String? username;
  String? password;
  String? avatar;
  String? registerTime;
  String? nickName;
  String? updateTime;
  String? lastLoginIp;
  String? lastLoginTime;
  String? token;
  String? uid;
  int? phoneNumber;
  int? userLevel;
  String? email;

  UserModel({
    this.username,
    this.password,
    this.avatar,
    this.registerTime,
    this.nickName,
    this.updateTime,
    this.lastLoginIp,
    this.token,
    this.lastLoginTime,
    this.uid,
    this.phoneNumber,
    this.userLevel,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    avatar = json['avatar'];
    registerTime = json['registerTime'];
    nickName = json['nickName'];
    updateTime = json['updateTime'];
    lastLoginIp = json['lastLoginIp'];
    token = json['token'];
    lastLoginTime = json['lastLoginTime'];
    uid = json['uid'];
    phoneNumber = json['phoneNumber'];
    userLevel = json['userLevel'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['avatar'] = avatar;
    data['registerTime'] = registerTime;
    data['nickName'] = nickName;
    data['updateTime'] = updateTime;
    data['lastLoginIp'] = lastLoginIp;
    data['token'] = token;
    data['lastLoginTime'] = lastLoginTime;
    data['uid'] = uid;
    data['phoneNumber'] = phoneNumber;
    data['userLevel'] = userLevel;
    data['email'] = email;
    return data;
  }
}

/// 登录请求
class UserLoginRequestModel {
  final String email;
  final String password;

  UserLoginRequestModel({
    required this.email,
    required this.password,
  });

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) {
    return UserLoginRequestModel(
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
