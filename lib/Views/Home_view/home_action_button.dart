import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/View_Providers/add_employee_dialog_provider.dart';
import 'package:leman_project/Views/Home_view/add_employee_dialog.dart';
import 'package:leman_project/Views/Home_view/offline_employee_adding_dialog.dart';
import 'package:provider/provider.dart';

class HomeActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => ChangeNotifierProvider<AddEmployeeProvider>(
                  create: (BuildContext context) => AddEmployeeProvider(),
                  child: AddEmployeeDialog(),
                )).then((value) {
          if (value == 'success')
            return Flushbar(
              message: 'Angajat adăugat',
              backgroundColor: Colors.green[300],
              duration: Duration(seconds: 3),
            )..show(context);
          if (value == 'offline')
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => OfflineEmployeeAddingDialog());
        });
      },
      backgroundColor: Colors.cyan[700],
      child: Icon(Icons.add),
    );
  }
}
