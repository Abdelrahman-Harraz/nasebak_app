import 'package:nasebak_app/apis/models/membership/membership_item_api_model.dart';

class MembershipItemUiModel {
  final String name;
  final bool isAvailable;

  MembershipItemUiModel({required this.name, required this.isAvailable});

  factory MembershipItemUiModel.fromApi(MembershipItemApiModel e) {
    return MembershipItemUiModel(name: e.name, isAvailable: e.isAvailable);
  }
}
