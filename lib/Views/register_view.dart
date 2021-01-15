import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/View_Providers/register_view_provider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerViewProvider =
        Provider.of<RegisterViewProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Creare cont",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  children: [
                    //Name field
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        registerViewProvider.name = value;
                        registerViewProvider.enabled();
                      },
                      decoration: InputDecoration(
                        labelText: "Nume întreg",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    //Email field
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        registerViewProvider.email = value;
                        registerViewProvider.enabled();
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    //Phone field
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onChanged: (String value) {
                        registerViewProvider.phone = value;
                        registerViewProvider.enabled();
                      },
                      decoration: InputDecoration(
                        labelText: "Telefon",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    //Password field
                    Selector<RegisterViewProvider, bool>(
                      selector: (context, registerProvider) =>
                          registerProvider.obscureText,
                      builder: (context, obscure, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: obscure,
                          onChanged: (String value) {
                            registerViewProvider.password = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            labelText: "Parola",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  registerViewProvider.obscure(1);
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
                    //Repeat password
                    Selector<RegisterViewProvider, bool>(
                      selector: (context, registerProvider) =>
                          registerProvider.obscureText2,
                      builder: (context, obscure2, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: obscure2,
                          onChanged: (String value) {
                            registerViewProvider.repeatPassword = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            labelText: "Repetare parolă",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  registerViewProvider.obscure(2);
                                },
                                child: obscure2 == false
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
              spacer(height(context) * 0.015, 0),
              //Register button
              Selector<RegisterViewProvider, bool>(
                selector: (context, registerProvider) =>
                    registerProvider.btnEnabled,
                builder: (context, bool, child) {
                  return RaisedButton(
                    color: Colors.cyan[700],
                    onPressed:
                        registerViewProvider.btnEnabled == false ? null : () {},
                    child: Text(
                      "Înregistrare",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              spacer(height(context) * 0.01, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aveți deja un cont? "),
                  InkWell(
                    child: Text(
                      "Click aici!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      //TODO: Navigare la login view.
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
