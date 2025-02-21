class GenderModel {
  final int id;
  final String text;

  GenderModel({required this.id, required this.text});

  static List<GenderModel> genders = [
    GenderModel(id: 1, text: "ذكر"),
    GenderModel(id: 2, text: "انثى"),
  ];
}
