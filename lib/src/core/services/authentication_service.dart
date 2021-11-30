import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herbarium_mobile/src/core/constants/preference_flags.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:herbarium_mobile/src/core/services/preferences_service.dart';
import 'package:logger/logger.dart';

import 'package:herbarium_mobile/src/core/locator.dart';

/// Manage the analytics of the application
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Logger _logger = locator<Logger>();

  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  final PreferencesService _preferencesService = locator<PreferencesService>();

  /// Firebase User.
  User? _user;

  User? get user => _user;

  Future<String?> get userToken async => await _user?.getIdToken();

  /// Log in the user with [provider], if [silent] is true, will try to connect silently
  Future<bool> signIn(AuthenticationProvider provider,
      {bool silent = false}) async {
    try {
      if (provider == AuthenticationProvider.google) {
        _user = await _signInWithGoogle(silent: silent);
      }
    } on Exception catch (e) {
      _logger.e(e.toString());
      _analyticsService.logError(runtimeType.toString(), "Sign in failed", e);
      return false;
    }

    if (_user == null) return false;
    _analyticsService.setUserProperties(_user!.uid);
    _preferencesService.setString(PreferenceFlag.userSignInProvider,
        provider.toString());
    return true;
  }

  Future<User?> _signInWithGoogle({bool silent = false}) async {
    GoogleSignInAccount? googleSignInAccount;

    if (silent) {
      _logger.i("Start silent sign in with Google");
      googleSignInAccount = await GoogleSignIn().signInSilently();

      if (googleSignInAccount == null) return null;
    } else {
      _logger.i("Start sign in with Google");
      googleSignInAccount = await GoogleSignIn().signIn();
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    if (userCredential.user != null) {
      return userCredential.user;
    }
    return null;
  }

  /// Log out the current user.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

enum AuthenticationProvider { google, apple }
