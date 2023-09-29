import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        log(state.toString());
        if (state.tasks != null) {
          return Container(
            child: ListView.builder(
              itemCount: state.tasks!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(state.tasks![index].name.toString()));
              },
            ),
          );
        } else {
          return Container(
            color: Colors.amber,
          );
        }
      },
    );
  }
}
