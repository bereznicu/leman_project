import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/Entities/ticket_entity.dart';
import 'package:leman_project/Entities/user_entity.dart';
import 'package:leman_project/Services/auth_service.dart';
import 'package:leman_project/View_Providers/employee_view_provider.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';

class EmployeesService extends ChangeNotifier {
  CollectionReference employeesRef =
      FirebaseFirestore.instance.collection('Angajati');
  final _authService = AuthService();
  StreamSubscription subscription;

  Future<String> addEmployee(String name) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection == true) {
      return employeesRef.add({'nume': name}).then((value) {
        if (value != null)
          return 'success';
        else
          return 'fail';
      }).catchError((error) {
        return error.toString();
      });
    } else
      employeesRef.add({'nume': name}).timeout(Duration(seconds: 5),
          onTimeout: () {
        print("stopped waiting");
      });
    return 'offline';
  }

  void retrieveEmployees(HomeViewProvider homeProvider) {
    employeesRef.snapshots().listen((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
      List<EmployeeEntity> employeesList =
          documentSnapshots.map<EmployeeEntity>((doc) {
        EmployeeEntity employeeEntity = new EmployeeEntity();
        return employeeEntity.toEmployeeEntity(doc.id, doc.data());
      }).toList();
      homeProvider.initList(employeesList);
    });
  }

  Future<String> addTicket(
      EmployeeEntity employeeEntity, TicketEntity ticketEntity) async {
    return _authService.getCurrentUser().then((UserEntity currentUser) async {
      ticketEntity.creator = currentUser.name;
      bool connection = await DataConnectionChecker().hasConnection;
      if (connection == true)
        return employeesRef
            .doc(employeeEntity.id)
            .collection('Tichete')
            .add(ticketEntity.toMap())
            .then((response) {
          return "success";
        }).catchError((error) {
          return error.toString();
        });
      else {
        employeesRef
            .doc(employeeEntity.id)
            .collection('Tichete')
            .add(ticketEntity.toMap());
        return 'offline';
      }
    });
  }

  Stream<QuerySnapshot> ticketsStream(
      EmployeeEntity employee, EmployeeViewProvider employeeProvider) {
    DateTime first = DateTime(employeeProvider.selectedDate.year,
        employeeProvider.selectedDate.month, 1);
    DateTime last = DateTime(employeeProvider.selectedDate.year,
        employeeProvider.selectedDate.month + 1, 0);
    return employeesRef
        .doc(employee.id)
        .collection("Tichete")
        .where('data', isGreaterThanOrEqualTo: first)
        .where('data', isLessThanOrEqualTo: last)
        .snapshots(includeMetadataChanges: true);
  }

  void ticketsStreamListen(
      EmployeeEntity employee, EmployeeViewProvider employeeProvider) {
    cancelStream();
    subscription =
        ticketsStream(employee, employeeProvider).listen((querySnapshot) {
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      List<TicketEntity> tickets = docs.map<TicketEntity>((doc) {
        return TicketEntity().fromMap(doc.data());
      }).toList();
      employeeProvider.initList(tickets);
    });
  }

  void cancelStream() {
    if (subscription != null) subscription.cancel();
  }
}
