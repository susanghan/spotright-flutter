import 'package:spotright/data/model/response_wrapper.dart';

class UserResponse implements ResponseConverter {
  int? memberId;
  int? followingsCnt;
  int? followersCnt;
  int? blockedsCnt;
  Null? memberPhoto;
  int? memberSpotsCnt;
  String? spotrightId;
  String? email;
  String? gender;
  String? birthdate;
  String? nickname;

  UserResponse(
      {this.memberId,
        this.followingsCnt,
        this.followersCnt,
        this.blockedsCnt,
        this.memberPhoto,
        this.memberSpotsCnt,
        this.spotrightId,
        this.email,
        this.gender,
        this.birthdate,
        this.nickname});

  UserResponse.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    followingsCnt = json['followingsCnt'];
    followersCnt = json['followersCnt'];
    blockedsCnt = json['blockedsCnt'];
    memberPhoto = json['memberPhoto'];
    memberSpotsCnt = json['memberSpotsCnt'];
    spotrightId = json['spotrightId'];
    email = json['email'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    nickname = json['nickname'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['followingsCnt'] = this.followingsCnt;
    data['followersCnt'] = this.followersCnt;
    data['blockedsCnt'] = this.blockedsCnt;
    data['memberPhoto'] = this.memberPhoto;
    data['memberSpotsCnt'] = this.memberSpotsCnt;
    data['spotrightId'] = this.spotrightId;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['nickname'] = this.nickname;
    return data;
  }
}