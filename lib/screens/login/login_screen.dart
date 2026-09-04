import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../layout/main_layout.dart'; // استيراد الشاشة الرئيسية
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // مسح أي رسائل سابقة
      ScaffoldMessenger.of(context).clearSnackBars();
      
      // رسالة ترحيبية صغيرة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم تسجيل الدخول بنجاح!',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppTheme.warmOrange,
          duration: Duration(seconds: 1),
        ),
      );

      // الانتقال الفعلي إلى الشاشة الحاضنة (الرئيسية)
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لضمان اتجاه التطبيق باللغة العربية
      child: Scaffold(
        backgroundColor: AppTheme.lightBackground,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // 1. الـ Header
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.charcoalGray,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -60,
                        left: -40,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppTheme.warmOrange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.school_outlined,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'UniMate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. محتوى نموذج تسجيل الدخول
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'مرحبًا بعودتك',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.charcoalGray,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'سجّل دخولك للمتابعة',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // حقل البريد الإلكتروني
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'البريد الإلكتروني',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.charcoalGray,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        // === التعديل هنا لجعله في اليمين ===
                        textAlign: TextAlign.right, 
                        textDirection: TextDirection.rtl, 
                        style: const TextStyle(
                          color: AppTheme.charcoalGray,
                          fontWeight: FontWeight.w600,
                        ),
                        // === التعديل هنا للتحقق الصارم من الإيميل ===
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          // كود التحقق من صيغة الإيميل (وجود @ ونقطة)
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'صيغة البريد الإلكتروني غير صحيحة';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'student@university.edu',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.mail_outline, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // حقل كلمة المرور
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'كلمة المرور',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.charcoalGray,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        // === التعديل هنا لجعله في اليمين ===
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: AppTheme.charcoalGray,
                          fontWeight: FontWeight.w600,
                        ),
                        // === التعديل هنا للتحقق من أن الطول 6 أرقام/أحرف فأكثر ===
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'يجب أن لا تقل كلمة المرور عن 6 أرقام أو أحرف';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),

                      // صف يحتوي على الزرين معاً
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                              );
                              // كود الانتقال لشاشة إنشاء الحساب
                            },
                            child: const Text(
                              'إنشاء حساب جديد',
                              style: TextStyle(
                                color: AppTheme.charcoalGray,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: AppTheme.warmOrange,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // زر تسجيل الدخول
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.warmOrange.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.warmOrange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // فاصل "أو سجل مع"
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1.5)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'أو سجّل مع',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1.5)),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // أزرار التسجيل الاجتماعي
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSocialButton('Apple', Icons.apple, Colors.black),
                          _buildSocialButton('Facebook', Icons.facebook, const Color(0xFF1877F2)),
                          _buildSocialButton('Google', Icons.g_mobiledata, const Color(0xFFEA4335), iconSize: 32),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة بناء أزرار التواصل الاجتماعي
  Widget _buildSocialButton(String text, IconData icon, Color iconColor, {double iconSize = 22}) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppTheme.charcoalGray,
            ),
          ),
        ],
      ),
    );
  }
}