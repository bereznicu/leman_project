import 'package:flutter/material.dart';

class DismissEmployeeAdderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Anulare adăugare angajat?"),
      actions: [
        //Dismiss
        FlatButton.icon(
          onPressed: () async {
            Navigator.pop(context, "dismissed");
          },
          icon: Icon(Icons.cancel),
          label: Text("Da"),
          color: Colors.red[300],
        ),
        //Don't dismiss
        FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.cyan[700],
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            label: Text(
              "Nu",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
