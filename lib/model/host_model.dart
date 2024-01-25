
/// 主机模型类
class HostModel {
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

  HostModel({
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

  HostModel.fromJson(Map<String, dynamic> json) {
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