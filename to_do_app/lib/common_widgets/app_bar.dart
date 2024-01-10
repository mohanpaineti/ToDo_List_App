import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/resource/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      this.text,
      this.onTapOfLeading,
      this.isNeedBackBtn = true,
      this.actions,
      this.leadingIcon});

  final String? text;
  final Function? onTapOfLeading;
  final bool isNeedBackBtn;
  final IconData? leadingIcon;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(text ?? '',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.nunito(fontSize: 19, fontWeight: FontWeight.w800)),
        elevation: 0,
        backgroundColor: AppColors.secondaryBackgroundColor,
        leading: isNeedBackBtn
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onTapOfLeading?.call() ?? context.pop(),
                child: Icon(leadingIcon ?? Icons.arrow_back_ios_new))
            : null,
        actions: actions);
  }
}
