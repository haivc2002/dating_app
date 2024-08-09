class ModelResponseMatch {
  String? result;
  String? message;
  int? matchId;
  List<int>? keyMatches;

  ModelResponseMatch(
      {this.result, this.message, this.matchId, this.keyMatches});

  ModelResponseMatch.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    matchId = json['matchId'];
    keyMatches = json['keyMatches'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['matchId'] = matchId;
    data['keyMatches'] = keyMatches;
    return data;
  }
}
