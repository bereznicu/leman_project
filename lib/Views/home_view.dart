import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/View_Providers/add_employee_dialog_provider.dart';
import 'package:leman_project/Views/add_employee_dialog.dart';
import 'package:leman_project/Views/offline_employee_adding_dialog.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var employeesService;
  @override
  void initState() {
    employeesService = context.read<EmployeesService>();
    employeesService.retrieveEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILD");
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
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
                backgroundColor: Colors.cyan[700],
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
      ),
      body: Column(
        children: <Widget>[
          //Search bar
          TextFormField(
            onChanged: (value) {
              employeesService.searchedString(value);
            },
            keyboardType: TextInputType.name,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Caută după nume",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          spacer(
              orientation(context) == 'portrait'
                  ? height(context) * 0.02
                  : height(context) * 0.04,
              0),
          Selector<EmployeesService, List<String>>(
              selector: (context, employeesService) =>
                  employeesService.filteredList,
              builder: (context, filteredList, child) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredList[index]),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
