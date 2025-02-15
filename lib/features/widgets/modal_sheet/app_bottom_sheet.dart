import 'package:flutter/material.dart';
import 'package:nasebak_app/features/widgets/modal_sheet/base_bottom_sheet_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';

class AppBottomSheet {
  static void openAppBottomSheet({
    required BuildContext context,
    required Widget child,
    ShapeBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    bool? isScrollControlled,
    bool withPadding = true,
    VoidCallback? onCloseCallBack,
  }) async {
    await showModalBottomSheet(
      barrierColor: AppColors.modalBottomSheetBarrier.withOpacity(0.5),
      context: context,
      isScrollControlled: isScrollControlled ?? false,
      shape: shape,
      builder:
          (context) => Padding(
            padding:
                withPadding
                    ? EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    )
                    : EdgeInsets.zero,
            child: BaseBottomSheetWidget(
              onCloseCallBack: onCloseCallBack,
              child: child,
            ),
          ),
    );
  }
}
