import 'package:nasebak_app/apis/models/membership/membership_features_api_model.dart';

class MembershipApiModel {
  final String id;
  final String name;
  final int duration;
  final String dateValue;
  final int price;
  final String currency;
  final String imageUrl;
  final List<MembershipFeaturesApiModel> features;

  MembershipApiModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.dateValue,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.features,
  });

  factory MembershipApiModel.fromJson(Map<String, dynamic> json) {
    return MembershipApiModel(
      id: json['id'],
      name: json['name'],
      duration: json['duration_in_months'],
      dateValue: json['dateValue'],
      price: json['price'],
      currency: json['currency'],
      imageUrl: json['image_url'],
      features:
          (json['features'] as List)
              .map((feature) => MembershipFeaturesApiModel.fromJson(feature))
              .toList(),
    );
  }
}
