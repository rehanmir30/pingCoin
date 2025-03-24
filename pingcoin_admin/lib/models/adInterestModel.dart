class AdInterestModel {
  String id = '';
  String name = '';

  AdInterestModel({required this.id, required this.name});

  factory AdInterestModel.fromMap(Map<String, dynamic> map) {
    return AdInterestModel(id: map["id"], name: map["name"]);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }
}
