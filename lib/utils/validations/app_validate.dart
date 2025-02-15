import 'package:nasebak_app/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/validations/validator.dart';
import 'package:flutter/material.dart';

mixin AppValidate {
  String? textValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateText(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? dropDownValidator(BuildContext context, CustomDropDownItem? value) {
    final ValidationState validationState = Validator.validateText(value?.key);
    switch (validationState) {
      case ValidationState.empty:
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.required);
      case ValidationState.valid:
        return null;
    }
  }

  String? textValidatorWithLength(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateTextWithLength(
      value,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? numberValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateNumber(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? numberValidatorWithLength(
    BuildContext context,
    String? value,
    int length,
  ) {
    final ValidationState validationState = Validator.validateNumberWithLength(
      value,
      length: length,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? decimalNumberValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateDecimal(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? validateNumberRange(
    BuildContext context,
    String? value, {
    int min = 1,
    int max = 100,
  }) {
    final ValidationState validationState = Validator.validateNumberRange(
      value,
      min: min,
      max: max,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return "${context.translate(LocalizationKeys.enterNumberlessThan)} $max";
      case ValidationState.valid:
        return null;
    }
  }

  String? emailOrPhoneNumberValidator(BuildContext context, String? value) {
    final ValidationState validationState =
        Validator.validateEmailOrPhoneNumber(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.emailInvalid);
      case ValidationState.valid:
        return null;
    }
  }

  String? emailValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateEmail(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.emailInvalid);
      case ValidationState.valid:
        return null;
    }
  }

  String? phoneNumberValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validatePhoneNumber(
      value,
      length: 11,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.phoneNumberInvalid);
      case ValidationState.valid:
        return null;
    }
  }

  String? confirmPasswordValidator(
    BuildContext context,
    String? value,
    String password,
  ) {
    final ValidationState validationState = Validator.validateTextWithText(
      value,
      password,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.passMatch);
      case ValidationState.valid:
        return null;
    }
  }

  String? passwordValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validatePassword(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.passInvalid);
      case ValidationState.valid:
        return null;
    }
  }

  String? fullNameValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateName(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.nameInvalid);
      case ValidationState.valid:
        return null;
    }
  }

  String? otpValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateNumberWithLength(
      value,
      length: 4,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.checkOtpCode);
      case ValidationState.valid:
        return null;
    }
  }
}
