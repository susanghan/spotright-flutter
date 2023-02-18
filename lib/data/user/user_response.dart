import 'package:spotright/data/model/response_wrapper.dart';

class UserResponse implements ResponseConverter {
  int memberId;
  int? followingsCnt;
  int? followersCnt;
  int? blockedsCnt;
  MemberPhoto? memberPhoto;
  int? memberSpotsCnt;
  String? spotrightId;
  String? email;
  String? gender;
  String? birthdate;
  String? nickname;

  UserResponse(
      {required this.memberId,
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

  UserResponse.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        followingsCnt = json['followingsCnt'],
        followersCnt = json['followersCnt'],
        blockedsCnt = json['blockedsCnt'],
        memberPhoto = json['memberPhoto'] != null
            ? MemberPhoto.fromJson(json['memberPhoto'])
            : null,
        memberSpotsCnt = json['memberSpotsCnt'],
        spotrightId = json['spotrightId'],
        email = json['email'],
        gender = json['gender'],
        birthdate = json['birthdate'],
        nickname = json['nickname'];

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['followingsCnt'] = followingsCnt;
    data['followersCnt'] = followersCnt;
    data['blockedsCnt'] = blockedsCnt;
    data['memberPhoto'] = memberPhoto;
    data['memberSpotsCnt'] = memberSpotsCnt;
    data['spotrightId'] = spotrightId;
    data['email'] = email;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['nickname'] = nickname;
    return data;
  }
}

class MemberPhoto {
  int? memberPhotoId;
  String? photoUrl;

  MemberPhoto({this.memberPhotoId, this.photoUrl});

  MemberPhoto.fromJson(Map<String, dynamic> json) {
    memberPhotoId = json['memberPhotoId'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberPhotoId'] = memberPhotoId;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
