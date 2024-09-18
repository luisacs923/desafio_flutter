import 'package:firebase_auth/firebase_auth.dart';

// serviços de autenticação firebase
class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
  Future<void> updateUserInfo({required String displayName}) async{
    var user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.updateDisplayName(displayName);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  User? getUserInfo(){
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> confirmEmail() async{
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }
}

