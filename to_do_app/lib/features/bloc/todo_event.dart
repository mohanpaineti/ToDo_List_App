// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TodoEvent {
  final Task task;
  const AddTaskEvent(
    this.task,
  );
}

class GetTaskEvent extends TodoEvent {
  const GetTaskEvent();
}

class DeleteTaskEvent extends TodoEvent {
  final int id;
  final int index;
  const DeleteTaskEvent(this.id , this.index);
}
