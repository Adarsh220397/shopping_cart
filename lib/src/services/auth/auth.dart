import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService._internal() {
    // _auth.authStateChanges().listen((User? user) async {
    //   _isFirebaseLoaded = true;
    //   _user = user;
    //   if (user == null) {
    //     print('AUTH --- The user is not yet logged in');
    //     // PreferenceManager.instance.clearAll();
    //   } else {
    //     print('AUTH --- The user login details are ${_user!.phoneNumber}');
    //     //await PreferenceManager.instance.setMobileNumber(_user!.phoneNumber!);

    //     await _updateCurrentUserInApp(_user!.uid);
    //   }
    //   _notifyClient(user);
    // });
  }
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  static logout() async {
    await _auth.signOut();
  }
}
