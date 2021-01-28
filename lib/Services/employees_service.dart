import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';

class EmployeesService extends ChangeNotifier {
  CollectionReference employees =
      FirebaseFirestore.instance.collection('Angajati');

  Future<String> addEmployee(String name) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection == true) {
      return employees.add({'nume': name}).then((value) {
        if (value != null)
          return 'success';
        else
          return 'fail';
      }).catchError((error) {
        return error.toString();
      });
    } else
      employees.add({'nume': name}).timeout(Duration(seconds: 5),
          onTimeout: () {
        print("stopped waiting");
      });
    return 'offline';
  }

  void retrieveEmployees(HomeViewProvider homeProvider) {
    employees.snapshots().listen((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
      List<String> employeesList = documentSnapshots.map<String>((doc) {
        return doc.data()['nume'];
      }).toList();
      homeProvider.initList(employeesList);
    });
  }
}
