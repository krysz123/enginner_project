import 'package:enginner_project/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:enginner_project/utils/exceptions/firebase_exceptions.dart';
import 'package:enginner_project/utils/exceptions/format_exceptions.dart';
import 'package:enginner_project/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

String handleExceptions(dynamic exception) {
  if (exception is FirebaseAuthException) {
    return CustomFirebaseAuthException(exception.code).message;
  } else if (exception is FirebaseException) {
    return CustomFirebaseException(exception.code).message;
  } else if (exception is FormatException) {
    return const CustomFormatException().message;
  } else if (exception is PlatformException) {
    return CustomPlatformException(exception.code).message;
  } else {
    return 'Coś poszło nie tak. Spróbuj ponownie';
  }
}
