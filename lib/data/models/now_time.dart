class NowTimeModel {
  String? datetime;

  NowTimeModel({
    this.datetime,
  });

  NowTimeModel.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
  }
}

class VoteTimeModel {
  final String datetime;

  VoteTimeModel(this.datetime);

  factory VoteTimeModel.fromJson(jsonData) {
    return VoteTimeModel(
      jsonData['datetime'],
    );
  }
}
