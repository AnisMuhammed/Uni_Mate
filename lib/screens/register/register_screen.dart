// lib/screens/register/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_theme.dart';
import '../../widgets/app_logo.dart';
import '../layout/main_layout.dart'; // استيراد الشاشة الحاضنة للتنقل

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // متحكمات النصوص (Controllers)
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _majorController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء الحساب بنجاح!',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppTheme.warmOrange,
          duration: Duration(seconds: 1),
        ),
      );

      // الانتقال الفعلي إلى الشاشة الحاضنة وإغلاق شاشات الدخول والتسجيل من الخلفية
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
          (Route<dynamic> route) => false, // تنظيف مسار التنقل (History)
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. زر الرجوع
                  _buildTopBar(),
                  const SizedBox(height: 20),

                  // 2. الشعار والعناوين
                  _buildHeader(),
                  const SizedBox(height: 32),

                  // 3. البيانات الأساسية
                  _buildSectionTitle('البيانات الأساسية'),
                  const SizedBox(height: 16),
                  _buildFieldLabel('الاسم الكامل'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _fullNameController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    textInputAction: TextInputAction.next,
                    style: _fieldTextStyle,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'يرجى إدخال اسمك الكامل'
                        : null,
                    decoration: _buildInputDecoration(
                      hintText: 'أدخل اسمك الثلاثي',
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFieldLabel('البريد الإلكتروني الجامعي'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    textInputAction: TextInputAction.next,
                    style: _fieldTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال البريد الإلكتروني';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'صيغة البريد الإلكتروني غير صحيحة';
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration(
                      hintText: 'student@university.edu.sa',
                      icon: Icons.mail_outline,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // الرقم الجامعي والتخصص جنباً إلى جنب
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildFieldLabel('الرقم الجامعي'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _studentIdController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              textInputAction: TextInputAction.next,
                              style: _fieldTextStyle,
                              validator: (value) =>
                                  (value == null || value.isEmpty) ? 'مطلوب' : null,
                              decoration: _buildInputDecoration(
                                hintText: '4410...',
                                icon: Icons.badge_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildFieldLabel('التخصص'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _majorController,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              textInputAction: TextInputAction.next,
                              style: _fieldTextStyle,
                              validator: (value) =>
                                  (value == null || value.isEmpty) ? 'مطلوب' : null,
                              decoration: _buildInputDecoration(
                                hintText: 'هندسة...',
                                icon: Icons.menu_book_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // 4. كلمة المرور
                  _buildSectionTitle('أمان الحساب'),
                  const SizedBox(height: 16),
                  _buildFieldLabel('كلمة المرور'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    textInputAction: TextInputAction.next,
                    style: _fieldTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'يجب أن لا تقل عن 6 أحرف/أرقام';
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration(
                      hintText: '••••••••',
                      icon: Icons.lock_outline,
                      suffixIcon: _buildEyeToggle(
                        obscured: _obscurePassword,
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFieldLabel('تأكيد كلمة المرور'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleRegister(),
                    style: _fieldTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى تأكيد كلمة المرور';
                      }
                      if (value != _passwordController.text) {
                        return 'كلمات المرور غير متطابقة';
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration(
                      hintText: '••••••••',
                      icon: Icons.lock_outline,
                      suffixIcon: _buildEyeToggle(
                        obscured: _obscureConfirmPassword,
                        onPressed: () => setState(
                            () => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 5. زر إنشاء الحساب
                  _buildPrimaryButton(),
                  const SizedBox(height: 32),

                  // 6. التسجيل بواسطة
                  _buildDivider('أو التسجيل بواسطة'),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          'جوجل',
                          Icons.g_mobiledata,
                          const Color(0xFFEA4335),
                          iconSize: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSocialButton(
                          'مايكروسوفت',
                          Icons.window,
                          Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // 7. رابط تسجيل الدخول
                  _buildLoginLink(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // قطع الواجهة
  // ==========================================

  static const TextStyle _fieldTextStyle = TextStyle(
    color: AppTheme.charcoalGray,
    fontWeight: FontWeight.w600,
  );

  Widget _buildTopBar() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppTheme.charcoalGray,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const AppLogo(size: 84),
        const SizedBox(height: 14),
        const Text(
          'UniMate',
          style: TextStyle(
            color: AppTheme.charcoalGray,
            fontSize: 24,
            fontWeight: FontWeight.w700, // Cairo Bold
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'إنشاء حساب جديد',
          style: TextStyle(
            color: AppTheme.charcoalGray,
            fontSize: 22,
            fontWeight: FontWeight.w700, // Cairo Bold
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'رفيقك الأكاديمي المثالي لتنظيم دراستك\nوتحقيق أهدافك بذكاء',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w400, // Cairo Regular
          ),
        ),
      ],
    );
  }

  // عنوان قسم بخط برتقالي صغير + فاصل — لتنظيم الشاشة
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppTheme.warmOrange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppTheme.charcoalGray,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _buildFieldLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.charcoalGray,
        ),
      ),
    );
  }

  Widget _buildEyeToggle({
    required bool obscured,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(
        obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: Colors.grey,
        size: 20,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
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
        onPressed: _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.warmOrange,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'إنشاء الحساب',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Cairo SemiBold
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(String label) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'لديك حساب بالفعل؟',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500, // Cairo Medium
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            // العودة لشاشة تسجيل الدخول
            Navigator.pop(context);
          },
          child: const Text(
            'تسجيل الدخول',
            style: TextStyle(
              color: AppTheme.warmOrange,
              fontWeight: FontWeight.w700, // Cairo Bold
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    String text,
    IconData icon,
    Color iconColor, {
    double iconSize = 22,
  }) {
    return Container(
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
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppTheme.charcoalGray,
            ),
          ),
        ],
      ),
    );
  }

  // أيقونة الحقل على اليمين (prefixIcon) لتطابق شاشة تسجيل الدخول
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
      prefixIcon: Icon(icon, color: Colors.grey),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}
