import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_signup_app/core/services/session_service.dart';
import 'package:flutter_login_signup_app/domain/repositories/auth_repository.dart';
import 'package:flutter_login_signup_app/injection/dependency_injection.dart';
import 'package:flutter_login_signup_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_login_signup_app/presentation/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                repository: getIt<AuthRepository>(),
                sessionService: getIt<SessionService>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Login Signup',

            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
