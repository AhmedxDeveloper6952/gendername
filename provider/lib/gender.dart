class GenderTeller {
  int? count;
  String? name;
  String? gender;
  double? probability;

  GenderTeller({this.count, this.name, this.gender, this.probability});

  GenderTeller.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    gender = json['gender'];
    probability = json['probability']?.toDouble();
  }
}
