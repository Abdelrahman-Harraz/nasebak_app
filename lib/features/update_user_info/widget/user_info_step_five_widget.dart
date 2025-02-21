import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoStepFiveWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;
  final String userName;

  const UserInfoStepFiveWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 5,
    this.totalSteps = 5,
    required this.userName,
  });

  @override
  State<UserInfoStepFiveWidget> createState() => _UserInfoStepFiveWidgetState();
}

class _UserInfoStepFiveWidgetState extends State<UserInfoStepFiveWidget> {
  int groupOneSelectedIndex = -1;
  int groupTwoSelectedIndex = -1;
  int groupThreeSelectedIndex = -1;
  int groupFourSelectedIndex = -1;
  double _startValue = 0;
  double _endValue = 10000;

  final List<List<String>> choices = [
    [
      'حكومي',
      'قطاع خاص',
      'رجل أعمال',
      'طالبـ / ـة',
      'متقاعد / ـة',
      'ابحث عن عمل',
    ],
    [
      'البكالوريوس',
      'الدبلوم',
      'الماجستير',
      'الدكتوراه',
      'بروفيسور',
      'ثانوية',
      'ابتدائي',
      'متوسط',
      'أمي',
    ],
    [
      'ملتزمـ / ـة جدا',
      'ملتزمـ / ـة',
      'محافظ  / ـة',
      'وسطي / ـة التدين',
      'غير ملتزمـ / ـة',
    ],
    ['نعم', 'لا', 'بعد مقابلة الأهل'],
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
                  AppAssetPaths.positionIcon,
                  context.translate(LocalizationKeys.position),
                  choices[0],
                  (index) => setState(() => groupOneSelectedIndex = index),
                  groupOneSelectedIndex,
                ),
                Divider(),
                SizedBox(height: 16),
                _buildTitle(
                  AppAssetPaths.incomeIcon,
                  context.translate(LocalizationKeys.income),
                ),
                _buildSlider(context),

                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.educationIcon,
                  context.translate(LocalizationKeys.education),
                  choices[1],
                  (index) => setState(() => groupTwoSelectedIndex = index),
                  groupTwoSelectedIndex,
                ),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.masjidIcon,
                  context.translate(LocalizationKeys.consistency),
                  choices[2],
                  (index) => setState(() => groupThreeSelectedIndex = index),
                  groupThreeSelectedIndex,
                ),
                Divider(),
                SizedBox(height: 16),
                _buildChoiceSection(
                  AppAssetPaths.smileIcon,
                  context.translate(LocalizationKeys.perspective),
                  choices[3],
                  (index) => setState(() => groupFourSelectedIndex = index),
                  groupFourSelectedIndex,
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
            '"${context.translate(LocalizationKeys.lifeWithYou)}"',
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
      ],
    );
  }

  Widget _buildSlider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'من ${_startValue.round()} ريال',
              textAlign: TextAlign.center,
              style: context.titleMedium!.copyWith(
                fontSize: 17,

                color: AppColors.stepFourTitle,
              ),
            ),
            Text(
              'إلى ${_endValue.round()} ريال',
              textAlign: TextAlign.center,
              style: context.titleMedium!.copyWith(
                fontSize: 17,

                color: AppColors.stepFourTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: 11),
        Theme(
          data: ThemeData(
            sliderTheme: SliderThemeData(
              thumbColor: AppColors.sliderThumbColor,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),

              overlayShape: SliderComponentShape.noOverlay,
            ),
          ),
          child: RangeSlider(
            values: RangeValues(_startValue, _endValue),
            min: _startValue,
            max: _endValue,
            activeColor: AppColors.sliderColor,
            inactiveColor: AppColors.sliderColor,
            divisions: 100,

            onChanged: (RangeValues newValues) {
              setState(() {
                _startValue = newValues.start;
                _endValue = newValues.end;
              });
            },
          ),
        ),
        SizedBox(height: 22),
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
