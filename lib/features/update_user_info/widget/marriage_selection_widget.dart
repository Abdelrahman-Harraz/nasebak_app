import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasebak_app/features/update_user_info/model/marriage_type_model.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class MarriageSelectionWidget extends StatelessWidget {
  final int? selectedMarriageId;
  final Function(int?) onMarriageSelected;
  final VoidCallback onNextPressed;

  const MarriageSelectionWidget({
    super.key,
    required this.selectedMarriageId,
    required this.onMarriageSelected,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 28.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              context.translate(LocalizationKeys.whatAreYouLookingFor),
              style: context.titleMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              context.translate(LocalizationKeys.marriageIsGood),
              style: context.titleMedium!.copyWith(fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              MarriageTypeModel.marriageType.map((marriageType) {
                bool isSelected = selectedMarriageId == marriageType.id;
                return GestureDetector(
                  onTap: () {
                    onMarriageSelected(marriageType.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Container(
                      height: 137,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color:
                            isSelected
                                ? Colors.white
                                : AppColors.marriageTypeSelectedBackground,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.genderSelectedBorder
                                  : AppColors.transparentColor,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Image.asset(
                              marriageType.imageUrl,
                              width: 68,
                              height: 68,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              marriageType.text,
                              style: context.titleMedium!.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 53, horizontal: 36),
          child: AppElevatedButton(
            onPressed: selectedMarriageId != null ? onNextPressed : null,
            label: Text(context.translate(LocalizationKeys.next)),
          ),
        ),
      ],
    );
  }
}
