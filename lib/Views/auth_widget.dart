import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';
import 'package:leman_project/View_Providers/login_view_provider.dart';
import 'package:leman_project/Views/Home_view/home_view.dart';
import 'package:leman_project/Views/login_view.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData
          ? ChangeNotifierProvider<HomeViewProvider>(
              create: (BuildContext context) => HomeViewProvider(),
              child: HomeView(),
            )
          : ChangeNotifierProvider<LoginViewProvider>(
              create: (BuildContext context) => LoginViewProvider(),
              child: LoginView(),
            );
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
