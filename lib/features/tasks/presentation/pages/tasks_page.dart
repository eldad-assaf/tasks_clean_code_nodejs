import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/remove_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/widgets/remove_task_dialog.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/widgets/update_task_dialog.dart';

class TasksPage extends StatefulWidget {
  @override
  createState() => _TasksPage();
}

class _TasksPage extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TasksError) {
          print(state.error.toString());
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (state.tasks != null && state.tasks!.isNotEmpty) {
          final List<TaskEntity> tasks = state.tasks!;
          return Container(
            child: ListView.builder(
              itemCount: state.tasks!.length,
              itemBuilder: (context, index) {
                final TaskEntity task = tasks[index];
                if (task.name != null &&
                    task.id != null &&
                    task.completed != null) {
                  return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text('remove'),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blue, // Color when swiping to the left
                        child: Center(
                          child: Text('Toggle finished'),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          bool confirmDelete = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return RemoveTaskDialog();
                            },
                          );
                          if (confirmDelete) {
                            BlocProvider.of<TasksBloc>(context).add(
                                RemoveTaskEvent(
                                    RemoveTaskRequest(id: task.id!)));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('${task.name} removed')));
                          }
                          return confirmDelete;
                        } else if (direction == DismissDirection.endToStart) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateTaskDialog(
                                task: task,
                              );
                            },
                          );
                        }
                        return null;
                      },
                      key: Key(task.id!),
                      child: ListTile(
                        title: Text(task.name!),
                        subtitle: task.completed == true
                            ? Text('Completed!')
                            : Text('Not completed'),
                        trailing: Switch(
                            value: task.completed!,
                            onChanged: (value) {
                              BlocProvider.of<TasksBloc>(context).add(
                                UpdateTaskEvent(
                                  UpdateTaskRequest(
                                    id: task.id!,
                                    newName: task.name,
                                    completed: !task.completed!,
                                  ),
                                ),
                              );
                            }),
                      ));
                }
                return null;
              },
            ),
          );
        } else if (state.tasks != null && state.tasks!.isEmpty) {
          return Center(
            child: Text('You have 0 tasks!'),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
