

class ContentModel {
  String about = "";
  String privacy = "";
  String terms = "";

  ContentModel({required this.about, required this.privacy, required this.terms});

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(about: map["About"], privacy: map["Privacy"], terms: map["Terms"]);
  }
}
