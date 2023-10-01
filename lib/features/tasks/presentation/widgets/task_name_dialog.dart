import 'package:flutter/material.dart';

class TaskNameDialog extends StatelessWidget {
  final TextEditingController _taskNameController = TextEditingController();
  final Function(String) onDonePressed;

  TaskNameDialog({required this.onDonePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Task Name'),
      content: TextField(
        controller: _taskNameController,
        decoration: InputDecoration(
          hintText: 'Task Name',
          errorText: _taskNameController.text.isEmpty
              ? 'Task name cannot be empty'
              : null,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Done'),
          onPressed: () {
            if (_taskNameController.text.isNotEmpty) {
              onDonePressed(_taskNameController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}