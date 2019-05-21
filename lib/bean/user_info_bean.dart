class UserInfo {
  String phoneNum;
  String token;

  UserInfo(this.phoneNum, this.token);

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.phoneNum = json["phoneNum"];
    this.token = json["token"];
  }

  Map<String, dynamic> toJson() {
    return {"phoneNum": phoneNum, "token": token};
  }
}
