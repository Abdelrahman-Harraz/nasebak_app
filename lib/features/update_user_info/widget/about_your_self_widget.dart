import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class AboutYourSelfWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;
  const AboutYourSelfWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 2,
    this.totalSteps = 2,
  });

  @override
  State<AboutYourSelfWidget> createState() => _AboutYourSelfWidgetState();
}

class _AboutYourSelfWidgetState extends State<AboutYourSelfWidget> {
  final TextEditingController _conditionsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _conditionsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                SizedBox(height: 59.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translate(LocalizationKeys.talkAboutYourSelf),
                        style: context.titleMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '"${context.translate(LocalizationKeys.goodCompanionship)}"',
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

                SizedBox(height: 24.h),
                _buildInputField(
                  context: context,
                  title: context.translate(
                    LocalizationKeys.doYouHaveAnyCondition,
                  ),
                  hint:
                      ("${context.translate(LocalizationKeys.stateYourCondition)}..."),
                  icon: AppAssetPaths.rulesIcon,
                  controller: _conditionsController,
                ),
                SizedBox(height: 12.h),
                _buildInputField(
                  context: context,
                  title: context.translate(LocalizationKeys.describeYourSelf),
                  hint: ("${context.translate(LocalizationKeys.yourRules)}..."),
                  icon: AppAssetPaths.penIcon,
                  controller: _descriptionController,
                ),
              ],
            ),
          ),
        ),

        SafeArea(
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
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String title,
    required String hint,
    required String icon,
    required BuildContext context,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
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
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  cursorColor: Colors.black,
                  controller: controller,
                  style: context.titleMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  maxLines: 4,
                  maxLength: 100,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    counterText: '',
                  ),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    '${controller.text.length}/100',
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
