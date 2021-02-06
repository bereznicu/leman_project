import 'package:flutter/material.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/View_Providers/employee_view_provider.dart';
import 'package:leman_project/Views/Single_employee_view/employee_view_action_button.dart';
import 'package:leman_project/Views/Single_employee_view/employee_view_body.dart';
import 'package:provider/provider.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key key, @required this.employee}) : super(key: key);
  final EmployeeEntity employee;

  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.employee.name),
      ),
      floatingActionButton: EmployeeViewActionButton(
        employee: widget.employee,
      ),
      body: ChangeNotifierProvider<EmployeeViewProvider>(
        create: (BuildContext context) => EmployeeViewProvider(),
        child: EmployeeViewBody(
          employee: widget.employee,
        ),
      ),
    );
  }
}
