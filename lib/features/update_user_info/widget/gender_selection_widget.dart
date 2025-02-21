import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasebak_app/features/update_user_info/model/gender_model.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class GenderSelectionWidget extends StatelessWidget {
  final int? selectedGenderId;
  final ValueChanged<int?> onGenderSelected;
  final VoidCallback onNextPressed;

  const GenderSelectionWidget({
    super.key,
    required this.selectedGenderId,
    required this.onGenderSelected,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        children: [
          SizedBox(height: 28.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              context.translate(LocalizationKeys.gender),
              style: context.titleMedium!.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                GenderModel.genders.map((gender) {
                  bool isSelected = selectedGenderId == gender.id;
                  return GestureDetector(
                    onTap: () => onGenderSelected(gender.id),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 358,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.genderSelectedBorder
                                    : AppColors.genderUnSelectedBorder,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          gender.text,
                          style: context.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 53),
            child: AppElevatedButton(
              onPressed: selectedGenderId != null ? onNextPressed : null,
              label: Text(context.translate(LocalizationKeys.next)),
            ),
          ),
        ],
      ),
    );
  }
}
