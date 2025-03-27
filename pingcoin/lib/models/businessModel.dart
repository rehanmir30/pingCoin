class BusinessDevelopmentModel {
  String id = "";
  String status = "";
  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String link = "";
  String image = "";
  String specificCode = "";
  String description = "";
  List<String> interestIds = [];
  String paymentStatus = "";
  String note="";
  DateTime starTime = DateTime.now();
  DateTime endTime = DateTime.now();

  BusinessDevelopmentModel(
      {required this.id,
      required this.status,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.link,
      required this.specificCode,
      required this.interestIds,
      required this.image,
      required this.paymentStatus,
      required this.description,
      required this.starTime,
        required this.note,
      required this.endTime});

  factory BusinessDevelopmentModel.fromMap(Map<String, dynamic> map) {
    return BusinessDevelopmentModel(
        id: map["id"],
        status: map["status"],
        fullName: map["fullName"],
        email: map["email"],
        phoneNumber: map["phoneNumber"],
        link: map["link"],
        specificCode: map["specificCode"],
        image: map["image"],
        paymentStatus: map["paymentStatus"],
        description: map["description"],
        note: map["note"],
        interestIds: List<String>.from(map["interestIds"] ?? []),
        starTime: map["startTime"].toDate(),
        endTime: map["endTime"].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "status": status,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "link": link,
      "specificCode": specificCode,
      "image": image,
      "paymentStatus":paymentStatus,
      "description": description,
      "interestIds": interestIds,
      "startTime": starTime,
      "endTime": endTime,
      "note":note
    };
  }
}
