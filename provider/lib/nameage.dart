class NameAge {
  int? count;
  String? name;
  int? age;

  NameAge({this.count, this.name, this.age});

  NameAge.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    age = json['age'];
  }
}
