import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/View_Providers/register_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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
                    Selector<RegisterViewProvider, String>(
                      selector: (context, registerProvider) =>
                          registerProvider.name,
                      builder: (context, name, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            registerViewProvider.setName = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            errorText: name != null && name.length > 0
                                ? null
                                : "Câmp obligatoriu",
                            labelText: "Nume întreg",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        );
                      },
                    ),
                    //Email field
                    Selector<RegisterViewProvider, String>(
                      selector: (context, registerProvider) =>
                          registerProvider.email,
                      builder: (context, email, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            registerViewProvider.setEmail = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            errorText: email == null ||
                                    !email.contains(
                                        RegExp(r'@[a-zA-Z]+\.[a-zA-Z]+'))
                                ? "Introduceți o adresă de e-mail validă"
                                : null,
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        );
                      },
                    ),
                    //Phone field
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onChanged: (String value) {
                        registerViewProvider.phone = value;
                        registerViewProvider.enabled();
                      },
                      decoration: InputDecoration(
                        labelText: "Telefon(opțional)",
                        prefixIcon: Icon(Icons.phone_outlined),
                        suffixIcon: Tooltip(
                          preferBelow: false,
                          message: "Va putea fi folosit la autentificare",
                          child: Icon(Icons.info_outline),
                          waitDuration: Duration(milliseconds: 0),
                        ),
                      ),
                    ),
                    //Password field
                    Selector<RegisterViewProvider, Tuple2<String, bool>>(
                      selector: (context, registerProvider) => Tuple2(
                          registerProvider.pass, registerProvider.obscurePass),
                      builder: (context, data, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: data.item2,
                          onChanged: (String value) {
                            registerViewProvider.setPass = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            errorText: data.item1 == null ||
                                    data.item1.length < 6
                                ? "Parola trebuie să conțină minim 6 caractere"
                                : null,
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
                    Selector<RegisterViewProvider,
                        Tuple3<String, bool, String>>(
                      selector: (context, registerProvider) => Tuple3(
                          registerProvider.repeatPass,
                          registerProvider.obscureRepeatPass,
                          registerProvider.pass),
                      builder: (context, data, child) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: data.item2,
                          onChanged: (String value) {
                            registerViewProvider.setRepeatPass = value;
                            registerViewProvider.enabled();
                          },
                          decoration: InputDecoration(
                            errorText: data.item1 != data.item3
                                ? "Parolele nu se potrivesc"
                                : null,
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
