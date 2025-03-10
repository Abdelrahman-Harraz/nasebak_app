import 'package:equatable/equatable.dart';
import 'package:nasebak_app/apis/models/vip_membership/vip_membership_api_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';

class VipMembershipUiModel extends Equatable {
  final int id;
  final String diamondCount;
  final String diamondImageUrl;
  final int price;
  final String currency;

  const VipMembershipUiModel({
    required this.id,
    required this.diamondCount,
    required this.diamondImageUrl,
    required this.price,
    required this.currency,
  });

  factory VipMembershipUiModel.fromApi(VipMembershipApiModel e) {
    return VipMembershipUiModel(
      id: e.id,
      diamondCount: e.diamondCount,
      diamondImageUrl: e.diamondImageUrl,
      price: e.price,
      currency: e.currency,
    );
  }

  static List<VipMembershipUiModel> dummy() {
    return [
      VipMembershipUiModel(
        id: 1,
        diamondImageUrl: AppAssetPaths.firstBoxDiamonds,
        diamondCount: "100",
        price: 299,
        currency: "رس",
      ),
      VipMembershipUiModel(
        id: 2,
        diamondImageUrl: AppAssetPaths.secondBoxDiamonds,
        diamondCount: "1000",
        price: 499,
        currency: "رس",
      ),
      VipMembershipUiModel(
        id: 3,
        diamondImageUrl: AppAssetPaths.thirdBoxDiamonds,
        diamondCount: "5000",
        price: 999,
        currency: "رس",
      ),
      VipMembershipUiModel(
        id: 4,
        diamondImageUrl: AppAssetPaths.fourthBoxDiamonds,
        diamondCount: "10000",
        price: 1499,
        currency: "رس",
      ),
    ];
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
