import 'package:nasebak_app/apis/models/membership/membership_api_model.dart';
import 'package:nasebak_app/features/membership/model/membership_features_ui_model.dart';
import 'package:nasebak_app/features/membership/model/membership_item_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';

class MembershipUiModel {
  final String id;
  final String name;
  final int duration;
  final String dateValue;
  final int price;
  final String currency;
  final String imageUrl;
  final List<MembershipFeaturesUiModel> features;
  bool? isGold;
  bool? isSilver;
  bool? isDiamond;

  MembershipUiModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.dateValue,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.features,
    this.isGold,
    this.isSilver,
    this.isDiamond,
  });

  factory MembershipUiModel.fromApiModel(MembershipApiModel apiModel) {
    return MembershipUiModel(
      id: apiModel.id,
      name: apiModel.name,
      duration: apiModel.duration,
      dateValue: apiModel.dateValue,
      price: apiModel.price,
      currency: apiModel.currency,
      imageUrl: apiModel.imageUrl,
      features:
          apiModel.features
              .map((feature) => MembershipFeaturesUiModel.fromApi(feature))
              .toList(),
    );
  }

  static List<MembershipUiModel> dummyMemberships() {
    return [
      MembershipUiModel(
        isSilver: true,
        id: "2",
        name: "الباقة الفضية",
        duration: 1,
        dateValue: "شهر",
        price: 100,
        currency: "رس",
        imageUrl: AppAssetPaths.silverMembershipLogo,
        features: [
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "دردشة بلا حدود", isAvailable: false),
              MembershipItemUiModel(name: "عدد الزيارات", isAvailable: true),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "شارة فضية", isAvailable: true),
              MembershipItemUiModel(name: "فرص ظهور أكثر", isAvailable: false),
              MembershipItemUiModel(
                name: "ظهور حالة الاتصال",
                isAvailable: false,
              ),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(
                name: "تعديل المعلومات",
                isAvailable: false,
              ),
              MembershipItemUiModel(name: "بحث لا محدود", isAvailable: false),
              MembershipItemUiModel(
                name: "إخفاء الإعلانات",
                isAvailable: false,
              ),
            ],
          ),
        ],
      ),
      MembershipUiModel(
        isGold: true,
        id: "1",
        name: "الباقة الذهبية",
        duration: 1,
        dateValue: "شهر",
        price: 150,
        currency: "رس",
        imageUrl: AppAssetPaths.goldenMembershipLogo,
        features: [
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "دردشة بلا حدود", isAvailable: true),
              MembershipItemUiModel(name: "عدد الزيارات", isAvailable: true),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "شارة ذهبية", isAvailable: true),
              MembershipItemUiModel(name: "فرص ظهور أكثر", isAvailable: true),
              MembershipItemUiModel(
                name: "ظهور حالة الاتصال",
                isAvailable: false,
              ),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(
                name: "تعديل المعلومات",
                isAvailable: false,
              ),
              MembershipItemUiModel(name: "بحث لا محدود", isAvailable: false),
              MembershipItemUiModel(name: "إخفاء الإعلانات", isAvailable: true),
            ],
          ),
        ],
      ),
      MembershipUiModel(
        isDiamond: true,
        id: "3",
        name: "الباقة الماسية",
        duration: 6,
        dateValue: "شهر",
        price: 600,
        currency: "رس",
        imageUrl: AppAssetPaths.diamondMembershipLogo,
        features: [
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "دردشة بلا حدود", isAvailable: false),
              MembershipItemUiModel(name: "عدد الزيارات", isAvailable: true),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(name: "شارة فضية", isAvailable: true),
              MembershipItemUiModel(name: "فرص ظهور أكثر", isAvailable: false),
              MembershipItemUiModel(
                name: "ظهور حالة الاتصال",
                isAvailable: false,
              ),
            ],
          ),
          MembershipFeaturesUiModel(
            category: "ميزات الملف الشخصي",
            items: [
              MembershipItemUiModel(
                name: "تعديل المعلومات",
                isAvailable: false,
              ),
              MembershipItemUiModel(name: "بحث لا محدود", isAvailable: false),
              MembershipItemUiModel(
                name: "إخفاء الإعلانات",
                isAvailable: false,
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
