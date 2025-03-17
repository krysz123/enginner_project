import 'package:enginner_project/app.dart';
import 'package:enginner_project/data/repositories/authentication/authentication_repository.dart';
import 'package:enginner_project/firebase_options.dart';
import 'package:enginner_project/periodic_transactions_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
          .then(
        (FirebaseApp value) => Get.put(AuthenticationRepository()),
      );
      Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
      );

      runApp(const App());
    },
  );
}
