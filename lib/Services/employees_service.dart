import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

class EmployeesService extends ChangeNotifier {
  CollectionReference employees =
      FirebaseFirestore.instance.collection('Angajati');
  List<String> employeesList = ['Se încarcă'];
  List<String> filteredList = ['Se încarcă'];

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
        print("stopped waiting XAXAXA");
      });
    return 'offline';
  }

  void searchedString(String value) {
    if (value == '' || value == null) {
      filteredList = employeesList;
    } else {
      filteredList =
          employeesList.where((employee) => employee.contains(value)).toList();
    }
    notifyListeners();
  }

  Stream<void> retrieveEmployees() {
    employees.snapshots().listen((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
      employeesList = documentSnapshots.map<String>((doc) {
        return doc.data()['nume'];
      }).toList();
      filteredList = employeesList;
      notifyListeners();
    });
  }
}
