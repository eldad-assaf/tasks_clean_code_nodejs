import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/remove_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/bloc/tasks_bloc.dart';

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
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (state.tasks != null && state.tasks!.isNotEmpty) {
          final List<TaskEntity> tasks = state.tasks!;
          ;
          return Container(
            child: ListView.builder(
              itemCount: state.tasks!.length,
              itemBuilder: (context, index) {
                final TaskEntity task = tasks[index];
                if (task.name != null &&
                    task.id != null &&
                    task.completed != null) {
                  return ListTile(
                      title: Text(task.name!),
                      subtitle:
                          Text(task.completed.toString() + ' ' + task.id!),
                      trailing: IconButton(
                        onPressed: () {
                          BlocProvider.of<TasksBloc>(context).add(
                              RemoveTaskEvent(RemoveTaskRequest(id: task.id!)));
                        },
                        icon: Icon(Icons.remove_circle),
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
