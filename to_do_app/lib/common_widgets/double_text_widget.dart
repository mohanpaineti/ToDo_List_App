import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/common_widgets/app_gap_width.dart';

class DoubleTextWidget extends StatelessWidget {
  const DoubleTextWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      this.needGap = true,
      this.style1,
      this.style2})
      : super(key: key);
  final String text1;
  final String text2;
  final TextStyle? style1;
  final TextStyle? style2;
  final bool needGap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (needGap) ...[
            Text(
              "$text1",
              style: style1 ??
                  GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),
            ),
          ] else ...[
            Text(
              "$text1 :",
              style: style1 ??
                  GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white),
            ),
            const GapW(10)
          ],
          Text(
            text2,
            maxLines: 3,
            style: style2 ??
                GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
