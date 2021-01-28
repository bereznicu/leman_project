import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:leman_project/Entities/user_entity.dart';

class FireStoreService {
  CollectionReference users =
      FirebaseFirestore.instance.collection('Utilizatori');
  Future<dynamic> storeUser(UserEntity userEntity) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection == true)
      return users
          .doc(userEntity.id)
          .set(userEntity.toMap())
          .then((value) => 'success')
          .catchError((error) => error.toString());
    else
      return users.doc(userEntity.id).set(userEntity.toMap());
  }
}
