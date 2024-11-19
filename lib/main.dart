import 'package:employees_today/app.dart';
import 'package:employees_today/dependency_injection.dart';
import 'package:employees_today/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialize();

  runApp(const App());
}
