import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   AuthCubit() : super(AuthInitial());
//   void checkAuthenticationStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     if (isLoggedIn) {
//       emit(AuthenticationAuthenticated());
//     } else {
//       emit(AuthenticationUnauthenticated());
//     }
//   }

//   void login(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       emit(AuthSuccess(user: userCredential.user));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         emit(AuthError(error: 'Invalid email or password'));
//       } else {
//         emit(AuthError(error: 'Login Error: $e'));
//       }
//     }
//   }

//   void signup(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       emit(AuthSuccess(user: userCredential.user));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         emit(AuthError(error: 'The account already exists for that email'));
//       } else {
//         emit(AuthError(error: 'Signup Error: $e'));
//       }
//     }
//   }
// }

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false) {
    _initAuthState();
  } // Initial state is not authenticated

  void _initAuthState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    emit(isLoggedIn);
  }

  void login(String email, String password) async {
    try {
      // Replace this with your Firebase authentication logic
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(
          msg: "Successfully Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      emit(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        // User not found
        Fluttertoast.showToast(
            msg: "Invalid Credential ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print('Authentication error: ${e.code}');
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      // Handle authentication error, for simplicity, just emit false
      emit(false);
    }
  }

  void logout() async {
    // Replace this with your Firebase sign out logic
    await FirebaseAuth.instance.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    emit(false);
  }

  void signUp(String email, String password) async {
    try {
      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(
          msg: "Successfully User Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);

      print('Sign-up error: $e');
      emit(false);
    }
  }
}
