import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

import 'package:nasebak_app/utils/validations/app_validate.dart';

class PhoneNumberWithCodeForm extends BaseStatefulWidget {
  final TextEditingController codeTextEditingController;
  final TextEditingController? phoneNumberTextEditingController;
  final Key? phoneFormKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(String?) onSavedPhoneNumber;
  final String? phoneNumber;
  final void Function(Country) onSelectCountryCode;
  final String? selectedCountryCode;
  final Color? formFieldColor;
  final bool disableCountrySelector;
  final bool useInternalForm;

  const PhoneNumberWithCodeForm({
    required this.codeTextEditingController,
    this.disableCountrySelector = true,
    this.phoneFormKey,
    this.autovalidateMode,
    required this.onSavedPhoneNumber,
    this.phoneNumber,
    required this.onSelectCountryCode,
    required this.selectedCountryCode,
    this.phoneNumberTextEditingController,
    super.key,
    this.formFieldColor,
    this.useInternalForm = true,
  });

  @override
  BaseState<PhoneNumberWithCodeForm> baseCreateState() =>
      _PhoneNumberWithCodeFormState();
}

class _PhoneNumberWithCodeFormState extends BaseState<PhoneNumberWithCodeForm>
    with AppValidate {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    if (widget.useInternalForm) {
      return Form(key: widget.phoneFormKey, child: _buildContent());
    } else {
      return _buildContent();
    }
  }

  Widget _buildContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AutofillGroup(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 28),
              Expanded(child: _phoneNumberTextFormField()),
              Container(
                width: 1,
                height: 24,
                color: AppColors.countryCodeDivider,
              ),
              _countryCode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneNumberTextFormField() {
    return TextFormField(
      controller: widget.phoneNumberTextEditingController,
      decoration: InputDecoration(
        hintText: context.translate(LocalizationKeys.pleaseEnterMobileNumber),
        hintStyle: TextStyle(color: AppColors.authHintText, fontSize: 16),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.phone,
      textDirection: TextDirection.rtl,
      validator: (value) => phoneNumberValidator(context, value),
      onSaved: widget.onSavedPhoneNumber,
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _countryCode() {
    return InkWell(
      onTap:
          widget.disableCountrySelector
              ? null
              : () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: widget.onSelectCountryCode,
                );
              },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              "${widget.selectedCountryCode}",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.countryCode,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.countryCode,
            ),
          ],
        ),
      ),
    );
  }
}
