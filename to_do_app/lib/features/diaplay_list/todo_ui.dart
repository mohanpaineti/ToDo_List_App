import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/common_widgets/app_bar.dart';
import 'package:to_do_app/common_widgets/app_text.dart';
import 'package:to_do_app/common_widgets/custopm_top_snackbar.dart';
import 'package:to_do_app/common_widgets/task_widget.dart';
import 'package:to_do_app/features/add_task/add_task_ui.dart';
import 'package:to_do_app/features/bloc/todo_bloc.dart';
import 'package:to_do_app/features/diaplay_list/task_model.dart';
import 'package:to_do_app/resource/app_colors.dart';
import 'package:to_do_app/resource/app_images.dart';
import 'package:to_do_app/resource/appstrings.dart';
import 'package:to_do_app/routers/routes_name.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    context.read<TodoBloc>().add(const GetTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: const CommonAppBar(
            text: "Task Lists",
          ),
          body: state.getTaskFormzStatus.isSubmissionInProgress
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : state.getTaskFormzStatus.isSubmissionSuccess
                  ? state.taskList.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                SvgPicture.asset(AppImages.emptyList),
                                const Positioned(
                                    bottom: 10,
                                    right: 0,
                                    left: 0,
                                    child: GoogleText(
                                      text: AppStrings.emptyListText,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListView.builder(
                            itemCount: state.taskList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                onUpdate: (details) {},
                                key: Key(state.items[index]),
                                child: TaskBoX(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return AddTaskScreen(
                                          title: state.taskList[index].title,
                                          index: state.taskList[index].id,
                                          category:
                                              state.taskList[index].category,
                                          discription:
                                              state.taskList[index].description,
                                          dueDate:
                                              state.taskList[index].dueDate,
                                          priority: parsePriority(
                                              state.taskList[index].priority),
                                        );
                                      },
                                    ));
                                  },
                                  index: index,
                                  task: Task(
                                    id: state.taskList[index].id,
                                    title: state.taskList[index].title,
                                    description:
                                        state.taskList[index].description,
                                    dueDate: state.taskList[index].dueDate,
                                    priority: state.taskList[index].priority,
                                    category: state.taskList[index].category,
                                    status: state.taskList[index].status,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  context.read<TodoBloc>().add(DeleteTaskEvent(
                                      state.taskList[index].id ?? 0, index));
                                  context
                                      .read<TodoBloc>()
                                      .add(const GetTaskEvent());

                                  CustomSnackBar.show(
                                      context: context,
                                      message: "item Removed");
                                },
                              );
                            },
                          ),
                        )
                  : const Center(
                      child: GoogleText(
                        text: AppStrings.errorMsg,
                        textColor: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FloatingActionButton(
              onPressed: () {
                context.push(AppRouteNames.addTask);
              },
              backgroundColor: AppColors.secondaryColor,
              shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 2.0),
              ),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
