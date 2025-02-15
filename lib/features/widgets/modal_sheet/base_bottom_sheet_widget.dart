import 'package:nasebak_app/_base/widgets/base_stateless_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore:must_be_immutable
class BaseBottomSheetWidget extends BaseStatelessWidget {
  BaseBottomSheetWidget({super.key, required this.child, this.onCloseCallBack});
  final Widget child;
  final VoidCallback? onCloseCallBack;

  @override
  Widget baseBuild(BuildContext context) {
    return Card(
      color: AppColors.modalBottomSheetBackground,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.modalBottomSheetDivider,
              height: 3.h,
              width: 75.w,
            ),
            SizedBox(height: 3.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () => _closeClicked(context),
                child: const Icon(
                  Icons.close,
                  size: 24,
                  weight: 300,
                  color: AppColors.modalBottomSheetCloseIcon,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }

  void _closeClicked(BuildContext context) {
    Navigator.of(context).pop();
    if (onCloseCallBack != null) {
      onCloseCallBack!();
    }
  }
}
