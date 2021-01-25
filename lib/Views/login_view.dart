import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:leman_project/View_Providers/login_view_provider.dart';
import 'package:leman_project/View_Providers/register_view_provider.dart';
import 'package:leman_project/Views/register_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewProvider =
        Provider.of<LoginViewProvider>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: orientation(context) == 'landscape'
                    ? EdgeInsets.only(top: height(context) * 0.1)
                    : EdgeInsets.only(top: 0.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (String value) {
                          loginViewProvider.emailPhone = value;
                          loginViewProvider.setBtnStatus();
                        },
                        decoration: InputDecoration(
                            labelText: "Email/Telefon",
                            prefixIcon: Icon(Icons.person_outline)),
                      ),
                      spacer(
                          orientation(context) == 'portrait'
                              ? height(context) * 0.015
                              : height(context) * 0.04,
                          0),
                      Selector<LoginViewProvider, bool>(
                        selector: (context, loginProvider) =>
                            loginProvider.obscureText,
                        builder: (context, obscure, child) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: obscure,
                            onChanged: (String value) {
                              loginViewProvider.password = value;
                              loginViewProvider.setBtnStatus();
                            },
                            decoration: InputDecoration(
                              labelText: "Parola",
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    loginViewProvider.obscure();
                                  },
                                  child: obscure == false
                                      ? Icon(Icons.visibility_outlined)
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                        )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              spacer(
                  orientation(context) == 'portrait'
                      ? height(context) * 0.015
                      : height(context) * 0.07,
                  0),
              Selector<LoginViewProvider, bool>(
                selector: (context, loginProvider) => loginProvider.btnEnabled,
                builder: (context, btnStatus, child) {
                  return RaisedButton(
                    color: Colors.cyan[700],
                    onPressed: btnStatus == false
                        ? null
                        : () async {
                            return authService
                                .login(loginViewProvider.emailPhone,
                                    loginViewProvider.password)
                                .then((value) {
                              if (value == 'fail')
                                return Flushbar(
                                  message: "Credențiale incorecte",
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                            });
                          },
                    child: Text(
                      "Autentificare",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              spacer(
                  orientation(context) == 'portrait'
                      ? height(context) * 0.01
                      : height(context) * 0.025,
                  0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nu aveți un cont?"),
                  InkWell(
                    child: Text(
                      "Click aici!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<RegisterViewProvider>(
                                    create: (BuildContext context) =>
                                        RegisterViewProvider(),
                                    child: RegisterView(),
                                  )));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
