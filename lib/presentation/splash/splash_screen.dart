import 'package:flutter/material.dart';
import 'package:flutter_login_signup_app/core/services/session_service.dart';
import 'package:flutter_login_signup_app/injection/dependency_injection.dart';
import 'package:flutter_login_signup_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:flutter_login_signup_app/presentation/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SessionService _sessionService;

  @override
  void initState() {
    super.initState();

    _sessionService = getIt<SessionService>();

    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await _sessionService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              ),
              child: Icon(Icons.person, size: 60.sp),
            ),

            SizedBox(height: 24.h),

            Text(
              'User Management',
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            Text(
              'Local Authentication Demo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),

            SizedBox(height: 40.h),

            SizedBox(
              width: 28.w,
              height: 28.w,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
