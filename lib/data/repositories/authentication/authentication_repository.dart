import 'package:enginner_project/features/app/screens/navigation/navigation.dart';
import 'package:enginner_project/features/authentication/screens/email_verify/email_verify.dart';
import 'package:enginner_project/features/authentication/screens/login/login.dart';
import 'package:enginner_project/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:enginner_project/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:enginner_project/utils/exceptions/firebase_exceptions.dart';
import 'package:enginner_project/utils/exceptions/format_exceptions.dart';
import 'package:enginner_project/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    redirectScreen();
  }

  Future<void> redirectScreen() async {
    final user = _auth.currentUser;

    if (user != null) {
      await _handleAuthenticatedUser(user);
    } else {
      await _handleUnauthenticatedUser();
    }
  }

  Future<void> _handleAuthenticatedUser(User user) async {
    if (user.emailVerified) {
      Get.offAll(
        () => const NavigationScreen(),
      );
    } else {
      Get.offAll(() => EmailVerificationScreen(email: user.email));
    }
  }

  Future<void> _handleUnauthenticatedUser() async {
    final shpref = await SharedPreferences.getInstance();

    if (shpref.getBool('onboarding') ?? false) {
      Get.offAll(() => const LoginScreen());
    } else {
      await shpref.setBool('onboarding', true);
      Get.offAll(const OnBoardingScreen());
    }
  }

  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie!';
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie!';
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Coś poszło nie tak. Spróbuj ponownie';
    }
  }
}
