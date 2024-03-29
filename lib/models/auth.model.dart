import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placer/models/store.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthModel {
  RxBool isAuth = false.obs;
  RxBool isAdmin = true.obs;


  void firebaseAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('FIREBASE | User is currently signed out!');
        logOut();
      } else {
        print('FIREBASE | User is signed in!');
        logIn(user);
      }
      print('setProjectReady');
      store.setProjectReady();
    });
  }

  void logIn(User firebaseUser) {
    isAuth.value = true;
    print('login');
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    isAuth.value = false;
  }
}
