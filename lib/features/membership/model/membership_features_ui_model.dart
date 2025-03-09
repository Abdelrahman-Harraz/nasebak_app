import 'package:nasebak_app/apis/models/membership/membership_features_api_model.dart';
import 'package:nasebak_app/features/membership/model/membership_item_ui_model.dart';

class MembershipFeaturesUiModel {
  final String category;
  final List<MembershipItemUiModel> items;

  MembershipFeaturesUiModel({required this.category, required this.items});

  factory MembershipFeaturesUiModel.fromApi(MembershipFeaturesApiModel e) {
    return MembershipFeaturesUiModel(
      category: e.category,
      items:
          e.items.map((item) => MembershipItemUiModel.fromApi(item)).toList(),
    );
  }
}
