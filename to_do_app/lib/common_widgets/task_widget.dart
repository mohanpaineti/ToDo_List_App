import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/common_widgets/app_gap_height.dart';
import 'package:to_do_app/common_widgets/app_gap_width.dart';
import 'package:to_do_app/common_widgets/app_text.dart';
import 'package:to_do_app/common_widgets/double_text_widget.dart';
import 'package:to_do_app/features/diaplay_list/task_model.dart';
import 'package:to_do_app/resource/app_colors.dart';
import 'package:to_do_app/resource/app_images.dart';
import 'package:to_do_app/resource/appstrings.dart';

class TaskBoX extends StatelessWidget {
  const TaskBoX({
    super.key,
    this.task,
    required this.index,
    this.animate,
    this.onTap,
  });

  final Task? task;
  final int index;
  final bool? animate;
  final Function? onTap;
  String changeTimeFormate(dateTime) {
    String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          border: Border.all(
              color: task?.status == Status.completed.name
                  ? AppColors.decorationColor
                  : AppColors.secondaryBackgroundColor.withOpacity(0.5),
              width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (task?.status == Status.completed.name) ...[
                  SizedBox(
                      height: 20,
                      child: Lottie.asset(AppImages.successLoti,
                          frameRate: FrameRate(40), repeat: false)),
                ] else ...[
                  SizedBox(
                      height: 20,
                      child: Lottie.asset(AppImages.errorLoti, repeat: false)),
                ],
                const GapW(5),
                GoogleText(
                  textAlign: TextAlign.end,
                  text: task?.status ?? "",
                  textColor: task?.status == Status.completed.name
                      ? AppColors.decorationColor
                      : task?.status == Status.inProgress.name
                          ? Colors.yellow
                          : Colors.blue,
                ),
                const Spacer(),
              ],
            ),
            const GapH(3),
            DoubleTextWidget(
              text1: AppStrings.title,
              text2: task?.title ?? "",
            ),
            DoubleTextWidget(
                text1: AppStrings.description, text2: task?.description ?? ""),
            DoubleTextWidget(
                text1: AppStrings.category, text2: task?.category ?? ""),
            const GapH(10),
            const GapH(5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.fillColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DoubleTextWidget(
                        text1: AppStrings.dueDate,
                        text2: changeTimeFormate(task?.dueDate) ?? ""),
                  ),
                  Expanded(
                    child: DoubleTextWidget(
                      text1: AppStrings.priority,
                      text2: task?.priority ?? "",
                    ),
                  ),
                  Expanded(
                    child: DoubleTextWidget(
                        text1: AppStrings.status, text2: task?.status ?? ""),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
