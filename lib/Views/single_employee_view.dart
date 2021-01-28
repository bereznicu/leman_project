import 'package:flutter/material.dart';
import 'package:leman_project/Entities/employee_entity.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key key, @required this.employee}) : super(key: key);
  final String employee;
  // final EmployeeEntity employee;
  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.employee),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[700],
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
