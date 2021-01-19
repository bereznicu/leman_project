import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Entities/user_entity.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:leman_project/View_Providers/register_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:flushbar/flushbar.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerViewProvider =
        Provider.of<RegisterViewProvider>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
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
                    Selector<RegisterViewProvider, String>(
                      selector: (context, registerProvider) =>
                          registerProvider.nameError,
                      builder: (context, nameError, child) {
                        return TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (String value) {
                            registerViewProvider.setName = value;
                            registerViewProvider.setNameError();
                            registerViewProvider.setBtnStatus();
                          },
                          decoration: InputDecoration(
                            errorText: nameError,
                            labelText: "Nume Prenume",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        );
                      },
                    ),
                    //Email field
                    Selector<RegisterViewProvider, String>(
                      selector: (context, registerProvider) =>
                          registerProvider.emailError,
                      builder: (context, emailError, child) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value) {
                            registerViewProvider.setEmail = value;
                            registerViewProvider.setEmailError();
                            registerViewProvider.setBtnStatus();
                          },
                          decoration: InputDecoration(
                            errorText: emailError,
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        );
                      },
                    ),
                    //Phone field
                    Selector<RegisterViewProvider, String>(
                        selector: (context, registerProvider) =>
                            registerProvider.phoneError,
                        builder: (context, phoneError, child) {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (String value) {
                              registerViewProvider.phone = value;
                              registerViewProvider.setPhoneError();
                              registerViewProvider.setBtnStatus();
                            },
                            decoration: InputDecoration(
                              errorText: phoneError,
                              labelText: "Telefon(opțional)",
                              prefixIcon: Icon(Icons.phone_outlined),
                              suffixIcon: Tooltip(
                                preferBelow: false,
                                message: "Va putea fi folosit la autentificare",
                                child: Icon(Icons.info_outline),
                                waitDuration: Duration(milliseconds: 0),
                              ),
                            ),
                          );
                        }),
                    //Password field
                    Selector<RegisterViewProvider, Tuple2<String, bool>>(
                      selector: (context, registerProvider) => Tuple2(
                          registerProvider.passError,
                          registerProvider.obscurePass),
                      builder: (context, data, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: data.item2,
                          onChanged: (String value) {
                            registerViewProvider.setPass = value;
                            registerViewProvider.setPassError();
                            registerViewProvider.setBtnStatus();
                          },
                          decoration: InputDecoration(
                            errorText: data.item1,
                            errorMaxLines: 3,
                            labelText: "Parola",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  registerViewProvider.setObscure('pass');
                                },
                                child: data.item2 == false
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                      )),
                          ),
                        );
                      },
                    ),
                    //Repeat password
                    Selector<RegisterViewProvider, Tuple2<String, bool>>(
                      selector: (context, registerProvider) => Tuple2(
                          registerProvider.repeatPassError,
                          registerProvider.obscureRepeatPass),
                      builder: (context, data, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: data.item2,
                          onChanged: (String value) {
                            registerViewProvider.setRepeatPass = value;
                            registerViewProvider.setRepeatPassError();
                            registerViewProvider.setBtnStatus();
                          },
                          decoration: InputDecoration(
                            errorText: data.item1,
                            labelText: "Repetare parolă",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  registerViewProvider.setObscure('repeatPass');
                                },
                                child: data.item2 == false
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
                    onPressed: registerViewProvider.btnEnabled == false
                        ? null
                        : () async {
                            final user = new UserEntity(
                                email: registerViewProvider.email,
                                name: registerViewProvider.name,
                                password: registerViewProvider.pass,
                                phone: registerViewProvider.phone);
                            await authService.register(user).then((result) {
                              if (result.contains('email'))
                                return Flushbar(
                                  message:
                                      "Există un cont creat cu această adresă de e-mail",
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                            });
                          },
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
