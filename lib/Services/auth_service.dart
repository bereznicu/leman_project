import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leman_project/Entities/user_entity.dart';
import 'package:leman_project/Services/firestore_service.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FireStoreService();

  Stream<User> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  Future<String> login(String email, String password) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection == true)
      return _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value);
        if (value.user != null) return 'success';
        return 'fail';
      }).catchError((error) => 'fail');
    else
      return 'offline';
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  Future<String> register(UserEntity user) async {
    bool connection = await DataConnectionChecker().hasConnection;
    if (connection == true)
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
    else
      return 'offline';
  }

  Future<UserEntity> getCurrentUser() async {
    return _fireStore.users
        .doc(_firebaseAuth.currentUser.uid)
        .get()
        .then((snapshot) {
      return UserEntity().fromMap(snapshot.data());
    });
  }
}
