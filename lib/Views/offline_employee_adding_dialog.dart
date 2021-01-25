import 'package:flutter/material.dart';

class OfflineEmployeeAddingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text("Offline"),
      content: Text(
          "Conexiune la internet nedectată. Angajatul va fi disponibil in baza de date de în dată ce se reia conexiunea."),
      actions: [
        FlatButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
          label: Text("Ok"),
          color: Colors.cyan[700],
        )
      ],
    );
  }
}
