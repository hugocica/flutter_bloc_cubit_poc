import 'package:cubit_poc/app/pages/home/cubits/todo_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  final List<String> _todos = [];

  List<String> get todos => _todos;

  TodoCubit() : super(InitialTodoState());

  /// function responsible for changing the cubit state
  /// and emit a new updated state
  Future<void> addTodo({required String todo}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(seconds: 1));

    if (_todos.contains(todo)) {
      emit(ErrorTodoState('Task already added.'));
    } else {
      _todos.add(todo);
      emit(LoadedTodoState(_todos));
    }
  }

  Future<void> removeTodo({required int index}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(seconds: 1));

    _todos.removeAt(index);
    emit(LoadedTodoState(_todos));
  }
}
