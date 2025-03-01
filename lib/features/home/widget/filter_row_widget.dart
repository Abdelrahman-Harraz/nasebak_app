import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';

class FilterRowWidget extends StatefulWidget {
  final bool isMaleSelected;
  const FilterRowWidget({super.key, required this.isMaleSelected});

  @override
  State<FilterRowWidget> createState() => _FilterRowWidgetState();
}

class _FilterRowWidgetState extends State<FilterRowWidget> {
  late bool isMaleSelected;
  String selectedCountry = "السعودية";
  String selectedCity = "الرياض";

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
            iconPath: AppAssetPaths.maleIcon,
            isSelected: isMaleSelected,
            onTap: () => setState(() => isMaleSelected = true),
          ),
          SizedBox(width: 8),
          _buildGenderIcon(
            iconPath: AppAssetPaths.femaleIcon,
            isSelected: !isMaleSelected,
            onTap: () => setState(() => isMaleSelected = false),
          ),
          SizedBox(width: 8),
          _buildDropdown(selectedCountry, (value) {
            setState(() {
              selectedCountry = value!;
            });
          }),
          SizedBox(width: 6),
          _buildDropdown(selectedCity, (value) {
            setState(() {
              selectedCity = value!;
            });
          }),
          SizedBox(width: 10),
          SvgPicture.asset(AppAssetPaths.searchIcon),
        ],
      ),
    );
  }

  Widget _buildGenderIcon({
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
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
    return Container(
      height: 29,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.filterDropDown,
        borderRadius: BorderRadius.circular(13),
      ),
      child: DropdownButton<String>(
        value: value,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
        underline: SizedBox(),
        style: TextStyle(
          color: AppColors.filterDropDownText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: AppColors.filterDropDownBackground,
        borderRadius: BorderRadius.circular(10),
        onChanged: onChanged,
        items:
            ["السعودية", "مصر", "الإمارات", "قطر", "الرياض"]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(color: AppColors.filterDropDownText),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
