import 'package:firebase_auth/firebase_auth.dart';
import 'package:leman_project/Entities/user_entity.dart';
import 'package:leman_project/Services/firestore_service.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FireStoreService();

  Future<String> register(UserEntity user) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) async {
      if (value != null) {
        user.id = value.user.uid;
        await value.user.sendEmailVerification();
        return await _fireStore.storeUser(user);
      }
    }).catchError((e) {
      return e.toString();
    });
  }
}
