class SignUpRequest {
  String? authProvider;
  String? birthdate;
  String? email;
  String? gender;
  String? nickname;
  String? spotrightId;
  String? password;
  String? passwordReEntered;
  String? registrationPath;

  SignUpRequest(
      {this.authProvider,
        this.birthdate,
        this.email,
        this.gender,
        this.nickname,
        this.spotrightId,
        this.password,
        this.passwordReEntered,
        this.registrationPath,
      });

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    authProvider = json['authProvider'];
    birthdate = json['birthdate'];
    email = json['email'];
    gender = json['gender'];
    nickname = json['nickname'];
    spotrightId = json['spotrightId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authProvider'] = authProvider;
    data['birthdate'] = birthdate;
    data['email'] = email;
    data['gender'] = gender;
    data['nickname'] = nickname;
    data['spotrightId'] = spotrightId;
    data['password'] = password;
    data['passwordReEntered'] = passwordReEntered;
    data['registrationPath'] = registrationPath;
    return data;
  }
}