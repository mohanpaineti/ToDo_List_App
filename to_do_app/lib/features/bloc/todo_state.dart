// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final FormzStatus addTaskFormzStatus;
  final FormzStatus getTaskFormzStatus;
  final FormzStatus deleteTaskFormzStatus;
  final List<Task> taskList;
  final List<String> items;

  // final FormzStatus addUserFormzStatus;
  // final FormzStatus loadUsersFormStatus;
  // final List<String> validPhoneNumbers;
  const TodoState({
    this.items = const [],
    this.taskList = const [],
    this.addTaskFormzStatus = FormzStatus.pure,
    this.getTaskFormzStatus = FormzStatus.pure,
    this.deleteTaskFormzStatus = FormzStatus.pure,
  });

  @override
  List<Object> get props => [
        addTaskFormzStatus,
        getTaskFormzStatus,
        taskList,
        items,
        deleteTaskFormzStatus
      ];

  TodoState copyWith(
      {FormzStatus? addTaskFormzStatus,
      FormzStatus? getTaskFormzStatus,
      FormzStatus? deleteTaskFormzStatus,
      List<String>? items,
      List<Task>? taskList}) {
    return TodoState(
        deleteTaskFormzStatus:
            deleteTaskFormzStatus ?? this.deleteTaskFormzStatus,
        items: items ?? this.items,
        addTaskFormzStatus: addTaskFormzStatus ?? FormzStatus.pure,
        getTaskFormzStatus: getTaskFormzStatus ?? this.getTaskFormzStatus,
        taskList: taskList ?? this.taskList);
  }
}
