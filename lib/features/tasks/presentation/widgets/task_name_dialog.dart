import 'package:flutter/material.dart';

class TaskNameDialog extends StatefulWidget {
  final Function(String) onDonePressed;

  TaskNameDialog({required this.onDonePressed});

  @override
  State<TaskNameDialog> createState() => _TaskNameDialogState();
}

class _TaskNameDialogState extends State<TaskNameDialog> {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Task Name'),
      content: TextField(
        maxLength: 20,
        onChanged: (value) {
          setState(() {});
        },
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
              widget.onDonePressed(_taskNameController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
