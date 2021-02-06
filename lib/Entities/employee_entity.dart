import 'package:leman_project/Entities/user_entity.dart';

class EmployeeEntity {
  String name, id;
  EmployeeEntity({this.name, this.id});

  EmployeeEntity toEmployeeEntity(String id, Map<String, dynamic> map) {
    return EmployeeEntity(id: id, name: map['nume']);
  }

  Map<String, dynamic> toMap(EmployeeEntity employee) {
    return {'id': employee.id, 'nume': employee.name};
  }
}
