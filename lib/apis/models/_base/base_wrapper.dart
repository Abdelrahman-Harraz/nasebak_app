import 'package:nasebak_app/apis/models/_base/details_model.dart';

abstract class BaseWrapper {
  final bool? isSuccess;
  final String message;
  final DetailsModel? details;
  final int? statusCode;

  const BaseWrapper(
    this.isSuccess,
    this.message,
    this.details, [
    this.statusCode,
  ]);

  BaseWrapper.fromJson(Map<String, dynamic> json)
    : statusCode = json["statusCode"],
      isSuccess = json['isSuccess'] as bool?,
      message = json['message'] as String? ?? "",
      details = DetailsModel.fromJson(json);
}
