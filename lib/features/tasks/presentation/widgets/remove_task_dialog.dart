import 'package:flutter/material.dart';

class RemoveTaskDialog extends StatelessWidget {
  RemoveTaskDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this task?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(true); // Returns true to confirm dismissal
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Returns false to cancel dismissal
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
