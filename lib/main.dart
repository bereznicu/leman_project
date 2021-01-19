import 'package:flutter/material.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'View_Providers/login_view_provider.dart';
import 'Views/login_view.dart';

Future<void> main() async {
  //TODO: Adding callback to initialize app
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.cyan[700],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ChangeNotifierProvider<LoginViewProvider>(
            create: (BuildContext context) => LoginViewProvider(),
            child: LoginView(),
          )),
    );
  }
}
