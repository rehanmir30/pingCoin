class CoinModel {
  String id = "";
  String name = "";
  String category = "";
  String country = "";
  String diameter = "";
  String diameterUnit = "";
  String weight = "";
  String weightUnit = "";
  String thickness = "";
  String thicknessUnit = "";
  String highLevel = "";
  String highLevelValidation = "";
  String coinFront="";
  String coinBack="";
  String coinAudio="";
  DateTime? createdAt;
  DateTime? updatedAt;
  String description="";

  CoinModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.country,
      required this.diameter,
      required this.diameterUnit,
      required this.weight,
      required this.weightUnit,
      required this.thickness,
      required this.thicknessUnit,
      required this.highLevel,
      required this.highLevelValidation,
        required this.description,
      required this.coinFront,
      required this.coinBack,
      required this.coinAudio,
      this.createdAt,
      this.updatedAt});

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
        id: map["id"],
        name: map["name"],
        category: map["category"],
        country: map["country"],
        diameter: map["diameter"],
        diameterUnit: map["diameterUnit"],
        weight: map["weight"],
        weightUnit: map["weightUnit"],
        thickness: map["thickness"],
        thicknessUnit: map["thicknessUnit"],
        highLevel: map["highLevel"],
        highLevelValidation: map["highLevelValidation"],
        coinFront: map["coinFront"],
        coinBack: map["coinBack"],
        coinAudio: map["coinAudio"],
        createdAt: map["createdAt"].toDate(),
        updatedAt: map["updatedAt"].toDate(),
      description: map["description"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "country": country,
      "diameter": diameter,
      "diameterUnit": diameterUnit,
      "weight": weight,
      "weightUnit": weightUnit,
      "thickness": thickness,
      "thicknessUnit": thicknessUnit,
      "highLevel": highLevel,
      "highLevelValidation": highLevelValidation,
      "coinFront":coinFront,
      "coinBack":coinBack,
      "coinAudio":coinAudio,
      "createdAt":createdAt,
      "updatedAt":updatedAt,
      "description":description
    };
  }
}
