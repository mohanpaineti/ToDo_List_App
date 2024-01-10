import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:to_do_app/features/diaplay_list/task_model.dart';
import 'package:to_do_app/resource/database_helper.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            addTaskFormzStatus: FormzStatus.submissionInProgress));
        final databaseHelper = DatabaseHelper();
        await databaseHelper.insertTask(event.task);

        emit(state.copyWith(addTaskFormzStatus: FormzStatus.submissionSuccess));
      } catch (e) {
        print(e);
        emit(state.copyWith(addTaskFormzStatus: FormzStatus.submissionFailure));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            deleteTaskFormzStatus: FormzStatus.submissionInProgress));
        final databaseHelper = DatabaseHelper();
        await databaseHelper.deleteTaskById(event.id);
        state.items.removeAt(event.index);

        // state.items.removeAt(event.id - 1);
        emit(state.copyWith(
          deleteTaskFormzStatus: FormzStatus.submissionSuccess,
        ));
      } catch (e) {
        print(e);
        emit(state.copyWith(
            deleteTaskFormzStatus: FormzStatus.submissionFailure));
      }
    });

    on<GetTaskEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            getTaskFormzStatus: FormzStatus.submissionInProgress));
        final databaseHelper = DatabaseHelper();
        List<Task> data = await databaseHelper.getTasks();

        List<String> items =
            List.generate(data.length, (index) => 'Item ${index + 1}');

        print(data);
        print("i amm called");
        emit(state.copyWith(
            getTaskFormzStatus: FormzStatus.submissionSuccess,
            taskList: data,
            items: items));
        print(state.getTaskFormzStatus);
      } catch (e) {
        print("nscmnjscs");
        print(e);
        emit(state.copyWith(getTaskFormzStatus: FormzStatus.submissionFailure));
      }
    });
  }
}
