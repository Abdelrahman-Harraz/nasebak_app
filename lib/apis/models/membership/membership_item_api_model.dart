class MembershipItemApiModel {
  final String name;
  final bool isAvailable;

  MembershipItemApiModel({required this.name, required this.isAvailable});

  factory MembershipItemApiModel.fromJson(Map<String, dynamic> json) {
    return MembershipItemApiModel(
      name: json['name'],
      isAvailable: json['is_available'],
    );
  }
}
