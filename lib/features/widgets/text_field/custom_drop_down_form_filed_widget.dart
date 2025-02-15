import 'package:nasebak_app/_base/widgets/base_stateless_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownItem extends Equatable {
  final String value;
  final String key;
  const CustomDropDownItem({required this.value, required this.key});

  @override
  List<Object?> get props => [value, key];
}

// ignore: must_be_immutable
class CustomDropDownFormFiledWidget extends BaseStatelessWidget {
  final List<CustomDropDownItem>? items;
  final String? hintText;
  final String? title;
  final Color? enableBorderColor;
  final ValueChanged<CustomDropDownItem?>? onChanged;
  final bool ignoring;
  CustomDropDownItem? initialValue;
  final bool withBorder;
  final FormFieldSetter<CustomDropDownItem>? onSaved;
  FormFieldValidator<CustomDropDownItem>? validator;
  Color? iconColor;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;

  final double? dropdownMaxHeight;
  final FocusNode? focusNode;
  CustomDropDownFormFiledWidget({
    super.key,
    this.items,
    this.title,
    this.itemTextStyle,
    this.enableBorderColor,
    this.ignoring = false,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.dropdownMaxHeight,
    this.initialValue,
    this.withBorder = true,
    this.iconColor,
    this.focusNode,
    this.hintTextStyle,
  });

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
              title!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.filterTitles,
              ),
            )
            : const EmptyWidget(),
        const SizedBox(height: 10),
        DropdownButtonFormField2<CustomDropDownItem>(
          decoration: InputDecoration(
            hintStyle: hintTextStyle ?? textTheme.labelMedium,
            isDense: true,
            fillColor: AppColors.appFormFieldFill,
            filled: true,
            contentPadding: EdgeInsetsDirectional.only(
              start: 1.w,
              end: 10.h,
              top: 15.h,
              bottom: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: enableBorderColor ?? AppColors.dropDownBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.formFieldFocusIBorder,
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          focusNode: focusNode,
          isExpanded: true,
          hint:
              initialValue != null
                  ? Text(initialValue!.value)
                  : Text(
                    hintText ?? '',
                    style: hintTextStyle ?? textTheme.labelMedium,
                  ),
          buttonStyleData: const ButtonStyleData(padding: EdgeInsets.zero),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 25.h,
              color: AppColors.suffixIcon,
            ),
          ),
          items: buildDropdownList(items),
          validator: validator,
          value: initialValue,
          onChanged: (value) {
            initialValue = value;
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          style: textTheme.bodyMedium?.copyWith(color: AppColors.formFieldText),
          onSaved: onSaved,
        ),
      ],
    );
  }

  List<DropdownMenuItem<CustomDropDownItem>>? buildDropdownList(
    List<CustomDropDownItem>? list,
  ) {
    return list == null || ignoring
        ? null
        : list.map((CustomDropDownItem item) {
          return DropdownMenuItem<CustomDropDownItem>(
            value: item,
            child: Text(item.value, style: itemTextStyle),
          );
        }).toList();
  }
}
