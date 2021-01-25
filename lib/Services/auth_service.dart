import 'package:firebase_auth/firebase_auth.dart';
import 'package:leman_project/Entities/user_entity.dart';
import 'package:leman_project/Services/firestore_service.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FireStoreService();

  Stream<User> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  Future<String> login(String email, String password) async {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      if (value.user != null) return 'success';
      return 'fail';
    }).catchError((error) => 'fail');
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  //De refactorizat, nu folosim await
  Future<String> register(UserEntity user) async {
    return _firebaseAuth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) async {
      if (value.user != null) {
        user.id = value.user.uid;
        await value.user.sendEmailVerification();
        return _fireStore.storeUser(user).then((value) {
          if (value == 'success')
            return 'success';
          else
            return 'fail';
        });
      }
    }).catchError((e) {
      return e.toString();
    });
  }
}
