import 'package:nasebak_app/apis/models/promote_profile/promote_profile_api_model.dart';

class PromoteProfileUiModel {
  final int id;
  final String duration;
  final String dateValue;
  final String feature;
  final int price;
  final String currency;

  const PromoteProfileUiModel({
    required this.id,
    required this.duration,
    required this.dateValue,
    required this.feature,
    required this.price,
    required this.currency,
  });

  factory PromoteProfileUiModel.fromJson(PromoteProfileApiModel e) {
    return PromoteProfileUiModel(
      id: e.id,
      duration: e.duration,
      dateValue: e.dateValue,
      feature: e.feature,
      price: e.price,
      currency: e.currency,
    );
  }

  static List<PromoteProfileUiModel> dummy() {
    return [
      PromoteProfileUiModel(
        id: 1,
        duration: "3",
        dateValue: "أيام",
        feature: "ظهور في الصفحة الرئيسية",
        price: 30,
        currency: "رس",
      ),
      PromoteProfileUiModel(
        id: 2,
        duration: "7",
        dateValue: "أيام",
        feature: "ظهور في الصفحة الرئيسية",
        price: 199,
        currency: "رس",
      ),
      PromoteProfileUiModel(
        id: 3,
        duration: "14",
        dateValue: "أيام",
        feature: "ظهور في الصفحة الرئيسية",
        price: 499,
        currency: "رس",
      ),
    ];
  }
}
