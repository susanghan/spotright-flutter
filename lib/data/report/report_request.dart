class ReportRequest {
  int? memberOrMemberSpotId;
  String? reason;
  String? reasonType;
  String? reportType;

  ReportRequest(
      {this.memberOrMemberSpotId,
        this.reason,
        this.reasonType,
        this.reportType});

  ReportRequest.fromJson(Map<String, dynamic> json) {
    memberOrMemberSpotId = json['memberOrMemberSpotId'];
    reason = json['reason'];
    reasonType = json['reasonType'];
    reportType = json['reportType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberOrMemberSpotId'] = memberOrMemberSpotId;
    data['reason'] = reason;
    data['reasonType'] = reasonType;
    data['reportType'] = reportType;
    return data;
  }
}