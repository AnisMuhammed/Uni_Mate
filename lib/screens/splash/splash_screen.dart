// lib/screens/splash/splash_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../widgets/app_logo.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // تأخير لمدة 3 ثوانٍ ثم الانتقال لشاشة تسجيل الدخول
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.charcoalGray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق الرسمي
            const AppLogo(size: 100),
            const SizedBox(height: 24),
            // اسم التطبيق
            const Text(
              'UniMate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            // النص التوضيحي
            const Text(
              'رفيقك في الحياة الجامعية',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500, // Cairo Medium
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your University Companion',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w400, // Cairo Regular
              ),
            ),
          ],
        ),
      ),
    );
  }
}