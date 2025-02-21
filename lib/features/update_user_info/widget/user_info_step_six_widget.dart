import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoStepSixWidget extends StatefulWidget {
  final VoidCallback? onNextPressed;
  final int currentStep;
  final int totalSteps;

  const UserInfoStepSixWidget({
    super.key,
    this.onNextPressed,
    this.currentStep = 6,
    this.totalSteps = 6,
  });

  @override
  State<UserInfoStepSixWidget> createState() => _UserInfoStepSixWidgetState();
}

class _UserInfoStepSixWidgetState extends State<UserInfoStepSixWidget> {
  int groupOneSelectedIndex = -1;

  double _age = 18;
  double _height = 0;
  double _weight = 0;
  bool? _acceptNationality;

  final List<List<String>> choices = [
    ['أبيض', 'بياض شامي', 'حنطي', ' حنطي فاتح', 'أسمر'],
  ];

  TextEditingController tribeTextEditingController = TextEditingController();
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
                SizedBox(height: 19),

                _buildSlider(
                  context,
                  icon: AppAssetPaths.ageIcon,
                  title: context.translate(LocalizationKeys.age),
                  valueTxt: context.translate(LocalizationKeys.year),
                  value: _age,
                  max: 100,
                  min: 18,
                  onChanged: (newValue) => setState(() => _age = newValue),
                ),
                Divider(),
                SizedBox(height: 19),

                _buildSlider(
                  context,
                  icon: AppAssetPaths.weightIcon,
                  title: context.translate(LocalizationKeys.weight),
                  valueTxt: context.translate(LocalizationKeys.kg),
                  value: _weight,
                  max: 200,
                  min: 0,
                  onChanged: (newValue) => setState(() => _weight = newValue),
                ),
                Divider(),
                SizedBox(height: 19),

                _buildSlider(
                  context,
                  icon: AppAssetPaths.tallIcon,
                  title: context.translate(LocalizationKeys.tall),
                  valueTxt: context.translate(LocalizationKeys.cm),
                  value: _height,
                  max: 200,
                  min: 0,
                  onChanged: (newValue) => setState(() => _height = newValue),
                ),
                Divider(),

                SizedBox(height: 17),
                _buildChoiceSection(
                  AppAssetPaths.skinIcon,
                  context.translate(LocalizationKeys.skin),
                  choices[0],
                  (index) => setState(() => groupOneSelectedIndex = index),
                  groupOneSelectedIndex,
                ),
                Divider(),
                SizedBox(height: 17),
                _tribeSection(context),

                Divider(),
                SizedBox(height: 17),

                _buildTitle(
                  AppAssetPaths.acceptNationalityIcon,
                  context.translate(LocalizationKeys.doYouAcceptNationality),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptNationality == true,
                      onChanged:
                          (value) => setState(() => _acceptNationality = true),
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all(Colors.white),
                      side: BorderSide(color: Colors.black),
                    ),
                    Text(
                      context.translate(LocalizationKeys.yes),
                      style: context.titleMedium!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stepFourTitle,
                      ),
                    ),
                    SizedBox(width: 25),
                    Checkbox(
                      value: _acceptNationality == false,
                      onChanged:
                          (value) => setState(() => _acceptNationality = false),
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all(Colors.white),
                      side: BorderSide(color: Colors.black),
                    ),
                    Text(
                      context.translate(LocalizationKeys.no),
                      style: context.titleMedium!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stepFourTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
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
            ('"${context.translate(LocalizationKeys.marriageIsPartnership)}"'),
            style: context.titleMedium!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '"${context.translate(LocalizationKeys.companionship)}"',
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
        SizedBox(height: 25),
      ],
    );
  }

  Widget _buildSlider(
    BuildContext context, {
    required String title,
    required String icon,
    required String valueTxt,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _buildTitle(icon, title),
            SizedBox(width: 11),
            Text(
              ' ( ${value.round()} $valueTxt )',
              textAlign: TextAlign.center,
              style: context.titleMedium!.copyWith(
                fontSize: 17,

                color: AppColors.stepFourTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: 28),
        Theme(
          data: ThemeData(
            sliderTheme: SliderThemeData(
              thumbColor: AppColors.sliderThumbColor,
              thumbSize: WidgetStateProperty.all(Size(3, 3)),
              overlayShape: SliderComponentShape.noOverlay,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppColors.sliderColor,
            inactiveColor: AppColors.sliderColor,
            divisions: (max - min).toInt(),

            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 25),
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

  Widget _tribeSection(BuildContext context) {
    return Column(
      children: [
        _buildTitle(
          AppAssetPaths.tribeIcon,
          context.translate(LocalizationKeys.tribe),
        ),
        TextFormField(
          cursorColor: Colors.black,
          controller: tribeTextEditingController,
          style: context.titleMedium!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: context.translate(LocalizationKeys.tribeName),
            hintStyle: context.titleMedium!.copyWith(
              fontSize: 18,
              color: AppColors.userInfoHintText,
            ),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
