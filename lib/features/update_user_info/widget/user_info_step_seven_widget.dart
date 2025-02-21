import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoStepSevenWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;

  const UserInfoStepSevenWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 7,
    this.totalSteps = 7,
  });

  @override
  State<UserInfoStepSevenWidget> createState() =>
      _UserInfoStepSevenWidgetState();
}

class _UserInfoStepSevenWidgetState extends State<UserInfoStepSevenWidget> {
  int groupOneSelectedIndex = -1;
  int groupTwoSelectedIndex = -1;
  int groupThreeSelectedIndex = -1;
  int groupFourSelectedIndex = -1;
  int groupFiveSelectedIndex = -1;

  final List<List<String>> choices = [
    [
      'أعزب',
      'عزباء',
      'أرمل',
      'أرملة',
      'متزوج',
      'متزوجة',
      'بكر',
      'مطلق',
      'مطلقة',
    ],
    ['مع والدهم', 'مع والدتهم', 'ليس لدي أطفال', 'لدي أطفال وسيظلون معي'],
    [
      'جميلـ / ـة',
      'وسيم',
      'متوسط / ـة الجمال',
      'مقبولـ / ـة',
      'عاديـ / ـة',
      'أقل من العادي',
    ],
    ['ناعم', 'مجعد', 'كيرلي', 'طويل', 'قصير'],
    ['سليمـ / ـة', 'ذوي احتياجات خاصة', 'مرض مزمن', 'عقيمـ / ـة'],
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
                  AppAssetPaths.ringIcon,
                  context.translate(LocalizationKeys.maritalStatus),
                  choices[0],
                  (index) => setState(() => groupOneSelectedIndex = index),
                  groupOneSelectedIndex,
                ),
                SizedBox(height: 22),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.babyCarIcon,
                  context.translate(LocalizationKeys.haveKids),
                  choices[1],
                  (index) => setState(() => groupTwoSelectedIndex = index),
                  groupTwoSelectedIndex,
                ),
                SizedBox(height: 22),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.faceIcon,
                  context.translate(LocalizationKeys.look),
                  choices[2],
                  (index) => setState(() => groupThreeSelectedIndex = index),
                  groupThreeSelectedIndex,
                ),
                SizedBox(height: 22),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.hairIcon,
                  context.translate(LocalizationKeys.hair),
                  choices[3],
                  (index) => setState(() => groupFourSelectedIndex = index),
                  groupFourSelectedIndex,
                ),
                SizedBox(height: 22),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.bedIcon,
                  context.translate(LocalizationKeys.health),
                  choices[4],
                  (index) => setState(() => groupFiveSelectedIndex = index),
                  groupFiveSelectedIndex,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate(LocalizationKeys.lastStep),
                style: context.titleMedium!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 11),
              SvgPicture.asset(AppAssetPaths.yellowSmileIcon),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            '"${context.translate(LocalizationKeys.stepsIsAllot)}"',
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
