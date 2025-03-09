import 'package:nasebak_app/apis/models/membership/membership_item_api_model.dart';

class MembershipFeaturesApiModel {
  final String category;
  final List<MembershipItemApiModel> items;

  MembershipFeaturesApiModel({required this.category, required this.items});

  factory MembershipFeaturesApiModel.fromJson(Map<String, dynamic> json) {
    return MembershipFeaturesApiModel(
      category: json['category'],
      items:
          (json['items'] as List)
              .map((item) => MembershipItemApiModel.fromJson(item))
              .toList(),
    );
  }
}
