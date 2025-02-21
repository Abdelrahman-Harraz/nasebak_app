import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoStepThreeWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;
  const UserInfoStepThreeWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 3,
    this.totalSteps = 3,
  });

  @override
  State<UserInfoStepThreeWidget> createState() =>
      _UserInfoStepThreeWidgetState();
}

class _UserInfoStepThreeWidgetState extends State<UserInfoStepThreeWidget> {
  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedNationality;

  final List<String> _countries = [
    'مصر',
    'المملكة العربية السعودية',
    'الإمارات العربية المتحدة',
    'قطر',
    'الكويت',
  ];
  final List<String> _cities = ['القاهرة', 'جدة', 'دبي', 'الدوحة', 'الكويت'];
  final List<String> _nationalities = [
    'مصري',
    'سعودي',
    'إماراتي',
    'قطري',
    'كويتي',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translate(LocalizationKeys.trueFeelings),
                        style: context.titleMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '"${context.translate(LocalizationKeys.lifeWithYou)}"',
                        style: context.titleMedium!.copyWith(
                          fontSize: 16,
                          color: AppColors.talkAboutText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                _buildDropdownField(
                  context: context,
                  title: context.translate(LocalizationKeys.nationality),
                  icon: AppAssetPaths.nationalityIcon,
                  value: _selectedNationality,
                  items: _nationalities,
                  onChanged:
                      (value) => setState(() => _selectedNationality = value),
                ),
                SizedBox(height: 24.h),
                _buildDropdownField(
                  context: context,
                  title: context.translate(LocalizationKeys.countryOfResidence),
                  icon: AppAssetPaths.countryIcon,
                  value: _selectedCountry,
                  items: _countries,
                  onChanged:
                      (value) => setState(() => _selectedCountry = value),
                ),
                SizedBox(height: 12.h),
                _buildDropdownField(
                  context: context,
                  title: context.translate(LocalizationKeys.city),
                  icon: AppAssetPaths.cityIcon,
                  value: _selectedCity,
                  items: _cities,
                  onChanged: (value) => setState(() => _selectedCity = value),
                ),
              ],
            ),
          ),
        ),

        _buildButton(context),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 36),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
          color: Colors.white,
        ),
        child: AppElevatedButton(
          onPressed: widget.onNextPressed ?? () {},
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.currentStep}/${widget.totalSteps}",
                style: context.titleMedium!.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.talkAboutBtnText,
                ),
              ),
              SizedBox(width: 8),
              Text(
                context.translate(LocalizationKeys.next),
                style: context.titleMedium!.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.talkAboutBtnText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String icon,
    required BuildContext context,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 8.w),
              Text(
                title,
                style: context.titleMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            items:
                items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
