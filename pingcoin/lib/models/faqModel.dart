class FAQModel {
  String id = "";
  String question = "";
  String answer = "";
  DateTime createdAt = DateTime.now();

  FAQModel({required this.id, required this.question, required this.answer, required this.createdAt});

  factory FAQModel.fromMap(Map<String, dynamic> map) {
    return FAQModel(id: map["id"], question: map["question"], answer: map["answer"], createdAt: map["createdAt"].toDate());
  }

  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "question":this.question,
      "answer":this.answer,
      "createdAt":this.createdAt
    };
  }
}
