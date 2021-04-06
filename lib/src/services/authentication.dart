import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/model/auth_request.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;
  Future<AuthenticationRequest> createUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  User getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AuthenticationRequest> logInUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  logOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    print(code);
    switch (code.toUpperCase()) {
      case 'USER-NOT-FOUND':
        authRequest.errorMessage = "User not found";
        break;
      case 'WRONG-PASSWORD':
        authRequest.errorMessage = "Incorrect password";
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authRequest.errorMessage = "Network error";
        break;
      case 'EMAIL-ALREADY-IN-USE':
        authRequest.errorMessage = "The email is already in use";
        break;
      default:
        authRequest.errorMessage = code;
    }
  }
}
