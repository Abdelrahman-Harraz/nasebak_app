import 'package:nasebak_app/res/app_asset_paths.dart';

class MarriageTypeModel {
  final int id;
  final String text;
  final String imageUrl;

  MarriageTypeModel({
    required this.id,
    required this.text,
    required this.imageUrl,
  });

  static List<MarriageTypeModel> marriageType = [
    MarriageTypeModel(
      id: 1,
      text: "معلن",
      imageUrl: AppAssetPaths.marriageType1,
    ),
    MarriageTypeModel(
      id: 2,
      text: "غير معلن",
      imageUrl: AppAssetPaths.marriageType2,
    ),
    MarriageTypeModel(
      id: 3,
      text: "حسب رغبة\n الطرف الاخر",
      imageUrl: AppAssetPaths.marriageType3,
    ),
  ];
}
