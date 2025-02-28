import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/home/home_api_model.dart';

class HomeWrapper extends BaseWrapper {
  final HomeApiModel? data;
  HomeWrapper(this.data, super.isSuccess, super.details, super.message);

  HomeWrapper.fromJson(super.json)
    : data = json["data"] != null ? HomeApiModel.fromJson(json["data"]) : null,
      super.fromJson();
}
