import 'package:equatable/equatable.dart';

class VipMembershipApiModel extends Equatable {
  final int id;
  final String diamondCount;
  final String diamondImageUrl;
  final int price;
  final String currency;

  const VipMembershipApiModel({
    required this.id,
    required this.diamondCount,
    required this.diamondImageUrl,
    required this.price,
    required this.currency,
  });

  factory VipMembershipApiModel.fromJson(Map<String, dynamic> json) {
    return VipMembershipApiModel(
      id: json["id"],
      diamondCount: json["diamondCount"],
      diamondImageUrl: json["diamondImageUrl"],
      price: json["price"],
      currency: json["currency"],
    );
  }
  @override
  List<Object?> get props => [
    id,
    diamondCount,
    diamondImageUrl,
    price,
    currency,
  ];
}
