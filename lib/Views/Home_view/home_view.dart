import 'package:flutter/material.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';
import 'package:leman_project/Views/Home_view/home_action_button.dart';
import 'package:leman_project/Views/Home_view/home_app_bar.dart';
import 'package:leman_project/Views/Home_view/home_body.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var employeesService;
  var homeProvider;
  @override
  void initState() {
    homeProvider = context.read<HomeViewProvider>();
    employeesService = context.read<EmployeesService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        homeProvider: homeProvider,
      ),
      floatingActionButton: HomeActionButton(),
      body: HomeBody(
        employeesService: employeesService,
        homeProvider: homeProvider,
      ),
    );
  }
}
