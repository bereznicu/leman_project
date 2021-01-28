import 'package:flutter/material.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/Services/firestore_service.dart';
import 'package:leman_project/Views/auth_widget.dart';
import 'package:leman_project/Views/auth_widget_builder.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FireStoreService>(
          create: (_) => FireStoreService(),
        ),
        ChangeNotifierProvider<EmployeesService>(
          create: (_) => EmployeesService(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (context, userSnapshot) {
          return MaterialApp(
            theme: ThemeData(primaryColor: Colors.cyan[700]),
            home: AuthWidget(
              userSnapshot: userSnapshot,
            ),
          );
        },
      ),
    );
  }
}
