import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/create_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/pages/tasks_page.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/widgets/task_name_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TasksPage(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('NodeJS Task App'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return TaskNameDialog(
                    onDonePressed: (taskName) {
                      BlocProvider.of<TasksBloc>(context).add(
                          CreateTaskEvent(CreateTaskRequest(name: taskName)));
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}
