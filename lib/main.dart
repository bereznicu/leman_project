import 'package:flutter/material.dart';
import 'package:leman_project/View_Providers/register_view_provider.dart';
import 'package:leman_project/Views/register_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.cyan[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChangeNotifierProvider<RegisterViewProvider>(
          create: (BuildContext context) => RegisterViewProvider(),
          child: RegisterView(),
        ));
  }
}
