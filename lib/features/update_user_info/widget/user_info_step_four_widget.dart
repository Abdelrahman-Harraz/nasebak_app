import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoStepFourWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;
  final String userName;

  const UserInfoStepFourWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 4,
    this.totalSteps = 4,
    required this.userName,
  });

  @override
  State<UserInfoStepFourWidget> createState() => _UserInfoStepFourWidgetState();
}

class _UserInfoStepFourWidgetState extends State<UserInfoStepFourWidget> {
  int groupOneSelectedIndex = -1;
  int groupTwoSelectedIndex = -1;
  int groupThreeSelectedIndex = -1;
  List<bool> groupFourSelections = List.generate(7, (_) => false);

  final List<List<String>> choices = [
    ['لا أشرب', 'احيانا', 'من فترة لأخرى', 'أحيانا في الليل', 'بشكل متكرر'],
    ['غير مدخن', 'غير منتظم', 'بانتظام', 'أحاول تركه'],
    ['كل يوم', 'غالبا', 'أحيانا', 'غير رياضي'],
    ['قطط', 'زواحف', 'سمك', 'سنجاب', 'هامستر', 'طيور', 'سلحفاة'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25.h),
        _buildHeader(context),
        SizedBox(height: 20),
        _buildDivider(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17),
                _buildChoiceSection(
                  AppAssetPaths.cupIcon,
                  context.translate(LocalizationKeys.doYouDrink),
                  choices[0],
                  (index) => setState(() => groupOneSelectedIndex = index),
                  groupOneSelectedIndex,
                ),
                _buildChoiceSection(
                  AppAssetPaths.smokeIcon,
                  context.translate(LocalizationKeys.smokeCount),
                  choices[1],
                  (index) => setState(() => groupTwoSelectedIndex = index),
                  groupTwoSelectedIndex,
                ),
                _buildChoiceSection(
                  AppAssetPaths.gymIcon,
                  context.translate(LocalizationKeys.exerciseCount),
                  choices[2],
                  (index) => setState(() => groupThreeSelectedIndex = index),
                  groupThreeSelectedIndex,
                ),
                _buildMultiSelectSection(
                  AppAssetPaths.pawIcon,
                  context.translate(LocalizationKeys.havePets),
                  choices[3],
                  groupFourSelections,
                  (index, selected) =>
                      setState(() => groupFourSelections[index] = selected),
                ),
                SizedBox(height: 16),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userName,
            style: context.titleMedium!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '"${context.translate(LocalizationKeys.yourLifeTheirLife)}"',
            style: context.titleMedium!.copyWith(
              fontSize: 16,
              color: AppColors.talkAboutText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceSection(
    String icon,
    String title,
    List<String> choices,
    Function(int) onSelected,
    int selectedIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(icon, title),
        SizedBox(height: 16),
        Wrap(
          spacing: 10,
          children: List.generate(choices.length, (index) {
            return ChoiceChip(
              label: Text(
                choices[index],
                style: const TextStyle(color: Colors.black),
              ),
              selected: selectedIndex == index,
              onSelected: (selected) => onSelected(selected ? index : -1),
              showCheckmark: false,
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: BorderSide(
                  color: selectedIndex == index ? Colors.red : Colors.grey,
                  width: 1,
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 22),
        Divider(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMultiSelectSection(
    String icon,
    String title,
    List<String> choices,
    List<bool> selections,
    Function(int, bool) onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(icon, title),
        SizedBox(height: 16),
        Wrap(
          spacing: 10,
          children: List.generate(choices.length, (index) {
            return FilterChip(
              label: Text(
                choices[index],
                style: const TextStyle(color: Colors.black),
              ),
              selected: selections[index],
              onSelected: (selected) => onSelected(index, selected),
              showCheckmark: false,
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
                side: BorderSide(
                  color: selections[index] ? Colors.red : Colors.grey,
                  width: 1,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTitle(String icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 16),
        Text(
          text,
          style: context.titleMedium!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.stepFourTitle,
          ),
        ),
      ],
    );
  }

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
}
