
import 'package:flutter/material.dart';
import 'package:to_do_app/common_widgets/app_text.dart';
import 'package:to_do_app/resource/app_colors.dart';

class AppCommonButton extends StatelessWidget {
  final double height;
  final double? width;
  final Color color;
  final Color? borderColor;
  final double radius;
  final Widget? child;
  final double? borderWidth;
  final double? fontSize;
  final Function onTap;
  final String text;
  final bool isEnable;
  final bool needShadow;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final bool isLoading;
  final Function? onValidation;
  final Color textColor;
  const AppCommonButton(
      {Key? key,
      this.height = 45,
      this.needShadow = true,
      this.fontSize,
      this.width,
      this.color = const Color(0xff009df5),
      this.borderColor = Colors.transparent,
      this.radius = 8,
      this.child,
      this.borderWidth = 1,
      required this.onTap,
      required this.text,
      this.isLoading = false,
      this.onValidation,
      this.textColor = Colors.white,
      this.margin,
      this.padding,
      this.isEnable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (isEnable && !isLoading) ? onTap() : null,
      // onTap: () => onTap(),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        margin: margin,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 35,
            ),
        decoration: BoxDecoration(
            color: isEnable ? color : AppColors.secondaryBackgroundColor,
            border: Border.all(color: borderColor!, width: borderWidth!),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: needShadow
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : []),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                )),
              )
            : GoogleText(
                text: text,
                textColor: textColor,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
