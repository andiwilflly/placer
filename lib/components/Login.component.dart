import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  Future<String> onLogin(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.name, // "admin@i.ua",
          password: data.password // "121314"
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }

    return '';
  }

  Future<String> onSignup(SignupData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.name ?? '', // "admin@i.ua",
          password: data.password ?? '' // "121314"
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }

    return '';
  }

  Future<String> _recoverPassword(String name) async {
    print('Name: $name');
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'placer.io',
        // logo: 'assets/images/rock_orange.png',
        onLogin: onLogin,
        onSignup: onSignup,
        onSubmitAnimationCompleted: () {
          print('onSubmitAnimationCompleted!');
        },
        onRecoverPassword: _recoverPassword,
        theme: LoginTheme(
          beforeHeroFontSize: 30,
          // primaryColor: Colors.white,
          // accentColor: Colors.black,
          // pageColorLight: Colors.blueAccent,
          // pageColorDark: Colors.blueAccent,
        ));
  }
}
