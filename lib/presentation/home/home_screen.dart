import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_signup_app/core/services/session_service.dart';
import 'package:flutter_login_signup_app/injection/dependency_injection.dart';
import 'package:flutter_login_signup_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_login_signup_app/presentation/auth/login/view/screen/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _loadUser();
  }

  Future<void> _loadUser() async {
    final mobile = await getIt<SessionService>().getUserMobile();

    if (mobile == null) return;

    if (!mounted) return;

    context.read<AuthBloc>().add(GetUserRequested(mobile));
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      if (!mounted) return;

      context.read<AuthBloc>().add(const LogoutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthFailure) {
            return Center(child: Text(state.message));
          }

          if (state is AuthSuccess) {
            final user = state.user;

            return SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: File(user.imagePath).existsSync()
                        ? FileImage(File(user.imagePath))
                        : null,
                    child: File(user.imagePath).existsSync()
                        ? null
                        : Icon(Icons.person, size: 50.sp),
                  ),

                  SizedBox(height: 24.h),

                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          _infoTile(title: 'Name', value: user.name),

                          Divider(height: 20.h),

                          _infoTile(title: 'Email', value: user.email),

                          Divider(height: 20.h),

                          _infoTile(title: 'Mobile', value: user.mobile),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton.icon(
                      onPressed: _showLogoutDialog,
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _infoTile({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: TextStyle(fontSize: 14.sp)),
        ),
      ],
    );
  }
}
