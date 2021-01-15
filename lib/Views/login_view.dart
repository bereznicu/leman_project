import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/View_Providers/login_view_provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewProvider =
        Provider.of<LoginViewProvider>(context, listen: false);
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
                          loginViewProvider.enabled();
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
                              loginViewProvider.enabled();
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
                builder: (context, bool, child) {
                  return RaisedButton(
                    color: Colors.blue,
                    onPressed:
                        loginViewProvider.btnEnabled == false ? null : () {},
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
                      //TODO: Navigare la register view.
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
