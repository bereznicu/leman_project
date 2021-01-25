import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leman_project/Entities/user_entity.dart';

class FireStoreService {
  CollectionReference users =
      FirebaseFirestore.instance.collection('Utilizatori');
  Future<String> storeUser(UserEntity userEntity) async {
    return users
        .doc(userEntity.id)
        .set(userEntity.toMap())
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }
}
