import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/bloc/tasks_bloc.dart';

class UpdateTaskDialog extends StatefulWidget {
  final TaskEntity task;
  UpdateTaskDialog({required this.task});

  @override
  State<UpdateTaskDialog> createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  late bool completed;
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    completed = widget.task.completed!;
    _nameController.text = widget.task.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length > 20) {
                  return 'Task name is too long';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
          ),
          SwitchListTile(
            value: completed,
            onChanged: (value) {
              setState(() {
                completed = value;
              });
            },
            title: Text('completed'),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<TasksBloc>(context).add(
                UpdateTaskEvent(
                  UpdateTaskRequest(
                    id: widget.task.id!,
                    newName: _nameController.text,
                    completed: completed,
                  ),
                ),
              );

              Navigator.pop(context);
            }
          },
          child: Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
