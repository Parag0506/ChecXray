import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.reference();

  Observable<FirebaseUser> user;
  Future<dynamic> profile;

  PublishSubject loading = PublishSubject();

  AuthService() {
    user = Observable(_auth.onAuthStateChanged);
    user.listen((u) {
      profile = _db.child('users/' + u.uid).once().then((s) => s.value);
    });
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user = await _auth.signInWithCredential(credential);

    updateUserData(user);
    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    return _db.child('users/' + user.uid).update({
      'uid': user.uid,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now().toString()
    });
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
