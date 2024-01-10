import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:to_do_app/common_widgets/app_bar.dart';
import 'package:to_do_app/common_widgets/app_button.dart';
import 'package:to_do_app/common_widgets/app_gap_height.dart';
import 'package:to_do_app/common_widgets/app_gap_width.dart';
import 'package:to_do_app/common_widgets/app_textfild.dart';
import 'package:to_do_app/common_widgets/custopm_top_snackbar.dart';
import 'package:to_do_app/features/bloc/todo_bloc.dart';
import 'package:to_do_app/features/diaplay_list/task_model.dart';
import 'package:to_do_app/resource/app_colors.dart';
import 'package:to_do_app/resource/appstrings.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen(
      {Key? key,
      this.title,
      this.status,
      this.category,
      this.discription,
      this.dueDate,
      this.index,
      this.priority})
      : super(key: key);
  final String? title;
  final String? discription;
  final String? category;
  final DateTime? dueDate;
  final Priority? priority;
  final Status? status;
  final int? index;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late final _titleController;
  late final _descriptionController;
  late final __categoryController;

  late DateTime _dueDate;
  late Priority? _priority;

  String _category = '';
  late Status? _status;
  @override
  void initState() {
    _dueDate = widget.dueDate ?? DateTime.now();
    _priority = widget.priority ?? Priority.low;
    __categoryController = TextEditingController(text: widget.category ?? "");
    _descriptionController =
        TextEditingController(text: widget.discription ?? "");
    _titleController = TextEditingController(text: widget.title ?? "");
    _status = widget.status ?? Status.newTask;
    context.read<TodoBloc>().add(const GetTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (ctx, state) {
        if (state.addTaskFormzStatus.isSubmissionSuccess) {
          context.read<TodoBloc>().add(const GetTaskEvent());
          context.pop();
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: const CommonAppBar(
              text: "Add Task",
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AppBorderTextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    hintText: "Title",
                  ),
                  const GapH(5),
                  AppBorderTextFormField(
                    controller: _descriptionController,
                    hintText: "Description",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                    maxLianes: 3,
                  ),
                  const GapH(10),
                  Row(
                    children: [
                      Expanded(
                        child: AppBorderTextFormField(
                          controller: TextEditingController(
                            text: DateFormat('dd-MM-yyyy').format(_dueDate),
                          ),
                          hintText: "Description",
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _dueDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.white,
                                      onPrimary:
                                          AppColors.secondaryBackgroundColor,
                                      onSurface: AppColors.fillColor,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _dueDate = selectedDate;
                              });
                            }
                          },
                        ),
                      ),
                      const GapW(4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: AppColors.fillColor,
                              width: 0.5,
                            )),
                        child: DropdownButton2<Priority>(
                          value: _priority,
                          items: Priority.values.map((priority) {
                            return DropdownMenuItem<Priority>(
                              value: priority,
                              child: Text(priority.toString().split('.').last),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _priority = value),
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey), // Hide underline
                          underline: Container(), // Remove default underline
                        ),
                      ),
                    ],
                  ),
                  const GapH(5),
                  AppBorderTextFormField(
                    onChanged: (value) => setState(() => _category = value),
                    controller: __categoryController,
                    hintText: "Category",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Category';
                      }
                      return null;
                    },
                  ),
                  const GapH(10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: AppColors.fillColor,
                          width: 0.5,
                        )),
                    child: DropdownButton2<Status>(
                      value: _status,
                      isExpanded: true,
                      items: Status.values.map((status) {
                        return DropdownMenuItem<Status>(
                          value: status,
                          child: Text(status.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _status = value),
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      underline: Container(),
                    ),
                  ),
                  const GapH(10),
                  AppCommonButton(
                    text: "Save Task",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final newTask = Task(
                          id: widget.index,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDate,
                          priority: _priority!.name,
                          category: __categoryController.text,
                          status: _status?.name ?? Status.newTask.name,
                        );
                        context.read<TodoBloc>().add(AddTaskEvent(newTask));
                      } else {
                        CustomSnackBar.show(
                            context: context, message: AppStrings.errorMsg2);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
