class AdModel {
  String id = '';
  String name = '';
  String image = '';
  List<String> interestIds = [];
  String link = "";
  String status = '';
  String specificCode = '';

  AdModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.interestIds,
      required this.link,
      required this.status,
      required this.specificCode});

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
        id: map["id"],
        name: map["name"],
        image: map["image"],
        interestIds: List<String>.from(map["interestIds"] ?? []),
        link: map["link"],
        status: map["status"],
        specificCode: map["specificCode"]);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "image": image, "interestIds": interestIds, "link": link, "status": status, "specificCode": specificCode};
  }
}
