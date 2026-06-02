import 'package:flutter/material.dart';
import 'package:flutter_login_signup_app/injection/dependency_injection.dart';
import 'package:flutter_login_signup_app/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const MyApp());
}
