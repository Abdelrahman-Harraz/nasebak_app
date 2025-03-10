import 'package:equatable/equatable.dart';

class PromoteProfileApiModel extends Equatable {
  final int id;
  final String duration;
  final String dateValue;
  final String feature;
  final int price;
  final String currency;

  const PromoteProfileApiModel({
    required this.id,
    required this.duration,
    required this.dateValue,
    required this.feature,
    required this.price,
    required this.currency,
  });

  factory PromoteProfileApiModel.fromJson(Map<String, dynamic> json) {
    return PromoteProfileApiModel(
      id: json["id"],
      duration: json["duration"],
      dateValue: json["dateValue"],
      feature: json["feature"],
      price: json["price"],
      currency: json["currency"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    duration,
    dateValue,
    feature,
    price,
    currency,
  ];
}
