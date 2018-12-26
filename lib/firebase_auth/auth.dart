import 'package:firebase_auth/firebase_auth.dart';

abstract class WxChatBaseAuth{
  Future<String> currentUser();
  Future<String> signIn(String email,String password);
  Future<String> createUser(String email,String password);
  Future<void> signOut();
}

class WxChatAuth implements WxChatBaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> createUser(String email, String password) async {
   FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
    return user.uid;
  }

  @override
  Future<String> currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
     return user != null ? user.uid : null;
  }

  @override
  Future<String> signIn(String email, String password) async{
   FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
    return user.uid;
  }

  @override
  Future<void> signOut() {
     return _firebaseAuth.signOut();
  }

}