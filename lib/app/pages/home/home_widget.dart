import 'package:cubit_poc/app/pages/home/cubits/todo_cubit.dart';
import 'package:cubit_poc/app/pages/home/cubits/todo_states.dart';
import 'package:cubit_poc/app/pages/home/widgets/todos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late final TodoCubit cubit;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TodoCubit>(context);
    cubit.stream.listen((state) {
      if (state is ErrorTodoState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: Text(
              state.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    });
  }

  void onRemove(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cubit Poc',
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BlocBuilder(
            bloc: cubit,
            builder: (ctx, state) {
              if (state is InitialTodoState) {
                return const Center(
                  child: Text('No task entered yet'),
                );
              } else if (state is LoadingTodoState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedTodoState) {
                return TodosList(
                  todos: state.todos,
                  onRemove: (id) => cubit.removeTodo(index: id),
                );
              } else {
                return TodosList(
                  todos: cubit.todos,
                  onRemove: (id) => cubit.removeTodo(index: id),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(0, -5),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter a task name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.addTodo(todo: _nameController.value.text);
                        _nameController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
