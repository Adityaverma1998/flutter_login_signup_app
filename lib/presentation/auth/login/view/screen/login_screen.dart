import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_signup_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_login_signup_app/presentation/auth/signup/view/screen/signup_screen.dart';
import 'package:flutter_login_signup_app/presentation/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess &&
                ModalRoute.of(context)?.isCurrent == true) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (_) => false,
              );
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80.h),

                    CircleAvatar(
                      radius: 50.r,
                      child: Icon(Icons.person, size: 50.sp),
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      'Login to continue',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),

                    SizedBox(height: 40.h),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter email';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 30.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading ? null : _login,
                        child: state is AuthLoading
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
