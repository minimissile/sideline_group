/// 用户模型类
class UserModel {
  String? birthday;
  int? gender;
  String? headImg;
  String? registerTime;
  String? nickName;
  String? updateTime;
  String? loginFailure;
  String? lastLoginIp;
  String? token;
  String? lastLoginTime;
  String? uid;
  int? phoneNumber;
  int? userLevel;
  int? voiceCount;
  String? email;
  int? status;
  String? username;

  UserModel({
    this.birthday,
    this.gender,
    this.headImg,
    this.registerTime,
    this.nickName,
    this.updateTime,
    this.loginFailure,
    this.lastLoginIp,
    this.token,
    this.lastLoginTime,
    this.uid,
    this.phoneNumber,
    this.userLevel,
    this.voiceCount,
    this.email,
    this.status,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    gender = json['gender'];
    headImg = json['headImg'];
    registerTime = json['registerTime'];
    nickName = json['nickName'];
    updateTime = json['updateTime'];
    loginFailure = json['loginFailure'];
    lastLoginIp = json['lastLoginIp'];
    token = json['token'];
    lastLoginTime = json['lastLoginTime'];
    uid = json['uid'];
    phoneNumber = json['phoneNumber'];
    userLevel = json['userLevel'];
    voiceCount = json['voiceCount'];
    email = json['email'];
    status = json['status'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['headImg'] = headImg;
    data['registerTime'] = registerTime;
    data['nickName'] = nickName;
    data['updateTime'] = updateTime;
    data['loginFailure'] = loginFailure;
    data['lastLoginIp'] = lastLoginIp;
    data['token'] = token;
    data['lastLoginTime'] = lastLoginTime;
    data['uid'] = uid;
    data['phoneNumber'] = phoneNumber;
    data['userLevel'] = userLevel;
    data['voiceCount'] = voiceCount;
    data['email'] = email;
    data['status'] = status;
    data['username'] = username;
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