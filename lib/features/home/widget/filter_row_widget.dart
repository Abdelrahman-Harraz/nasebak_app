import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';

class FilterRowWidget extends StatefulWidget {
  final bool isMaleSelected;
  final VoidCallback? onTap;

  const FilterRowWidget({super.key, required this.isMaleSelected, this.onTap});

  @override
  State<FilterRowWidget> createState() => _FilterRowWidgetState();
}

class _FilterRowWidgetState extends State<FilterRowWidget> {
  late bool isMaleSelected;
  String selectedCountry = "السعودية";
  String selectedCity = "الرياض";

  final Map<String, List<String>> countryCityMap = {
    "السعودية": ["الرياض", "جدة", "مكة", "الدمام"],
    "مصر": ["القاهرة", "الإسكندرية", "الجيزة", "شرم الشيخ"],
    "الإمارات": ["دبي", "أبو ظبي", "الشارقة", "عجمان"],
    "قطر": ["الدوحة", "الخور", "الوكرة", "الريان"],
  };

  @override
  void initState() {
    super.initState();
    isMaleSelected = widget.isMaleSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
      child: Row(
        children: [
          _buildGenderIcon(
            AppAssetPaths.maleIcon,
            isMaleSelected,
            () => _toggleGender(true),
          ),
          const SizedBox(width: 8),
          _buildGenderIcon(
            AppAssetPaths.femaleIcon,
            !isMaleSelected,
            () => _toggleGender(false),
          ),
          const SizedBox(width: 8),
          _buildDropdown(selectedCountry, _onCountryChanged),
          const SizedBox(width: 6),
          _buildDropdown(selectedCity, _onCityChanged),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: widget.onTap,
            child: SvgPicture.asset(AppAssetPaths.searchIcon),
          ),
        ],
      ),
    );
  }

  void _toggleGender(bool isMale) => setState(() => isMaleSelected = isMale);

  Widget _buildGenderIcon(
    String iconPath,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration:
                isSelected
                    ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.filterSelectedBorder,
                        width: 5,
                      ),
                    )
                    : null,
            child: SvgPicture.asset(
              iconPath,
              width: isSelected ? 35 : 41,
              height: isSelected ? 35 : 41,
            ),
          ),
          if (!isSelected)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.filterNotSelectedBorder,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return GestureDetector(
      onTap:
          () => _showPicker(
            context,
            value == selectedCountry
                ? countryCityMap.keys.toList()
                : countryCityMap[selectedCountry]!,
            onChanged,
          ),
      child: Container(
        height: 29,
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: AppColors.filterDropDown,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                color: AppColors.filterDropDownText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _onCountryChanged(String? value) {
    if (value != null) {
      setState(() {
        selectedCountry = value;
        selectedCity = countryCityMap[value]!.first;
      });
    }
  }

  void _onCityChanged(String? value) {
    if (value != null) setState(() => selectedCity = value);
  }

  void _showPicker(
    BuildContext context,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bottomSheetBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String tempSelected =
            options.contains(selectedCountry) ? selectedCountry : selectedCity;
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.bottomSheetDrawer,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      options.contains(selectedCountry)
                          ? 'اختر الدولة'
                          : 'اختر المدينة',
                      style: TextStyle(
                        color: AppColors.filterDropDownText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...options.map(
                  (option) => RadioListTile<String>(
                    title: Text(
                      option,
                      style: TextStyle(color: AppColors.filterDropDownText),
                    ),
                    activeColor: Colors.white,
                    value: option,
                    groupValue: tempSelected,
                    onChanged: (value) => setState(() => tempSelected = value!),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      onChanged(tempSelected);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "تأكيد",
                      style: context.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
