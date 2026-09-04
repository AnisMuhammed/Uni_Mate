// lib/screens/register/register_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1. الشعار (Logo)
                    const SizedBox(height: 20),
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: AppTheme.charcoalGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'UniMate',
                      style: TextStyle(
                        color: AppTheme.charcoalGray,
                        fontSize: 24,
                        fontWeight: FontWeight.w700, // Cairo Bold
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. العناوين
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
                    const SizedBox(height: 32),

                    // 3. الحقول
                    
                    // --- حقل الاسم الكامل ---
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('الاسم الكامل', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _fullNameController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                      validator: (value) => value!.isEmpty ? 'يرجى إدخال اسمك الكامل' : null,
                      decoration: _buildInputDecoration(
                        hintText: 'أدخل اسمك الثلاثي',
                        leftIcon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- حقل البريد الإلكتروني ---
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('البريد الإلكتروني الجامعي', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'صيغة البريد الإلكتروني غير صحيحة';
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: 'student@university.edu.sa',
                        leftIcon: Icons.mail_outline,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- حقل الرقم الجامعي والتخصص (بجانب بعض) ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الرقم الجامعي (يمين)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('الرقم الجامعي', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _studentIdController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                                decoration: _buildInputDecoration(
                                  hintText: '4410...',
                                  leftIcon: Icons.badge_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // التخصص (يسار)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('التخصص', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _majorController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                                decoration: _buildInputDecoration(
                                  hintText: 'هندسة...',
                                  leftIcon: Icons.menu_book_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- حقل كلمة المرور ---
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('كلمة المرور', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
                        if (value.length < 6) return 'يجب أن لا تقل عن 6 أحرف/أرقام';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5)),
                        suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                        prefixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey, size: 20),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- حقل تأكيد كلمة المرور ---
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('تأكيد كلمة المرور', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.charcoalGray)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppTheme.charcoalGray, fontWeight: FontWeight.w600),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'يرجى تأكيد كلمة المرور';
                        if (value != _passwordController.text) return 'كلمات المرور غير متطابقة';
                        return null;
                      },
                      decoration: _buildInputDecoration(
                        hintText: '••••••••',
                        leftIcon: Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 4. زر إنشاء الحساب (باللون البرتقالي الدافئ المطابق لشاشة الدخول)
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
                        onPressed: _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.warmOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'إنشاء الحساب',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600, // Cairo SemiBold
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 5. فاصل "أو التسجيل بواسطة"
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'أو التسجيل بواسطة',
                            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 6. أزرار جوجل ومايكروسوفت
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton('جوجل', Icons.g_mobiledata, const Color(0xFFEA4335), iconSize: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSocialButton('مايكروسوفت', Icons.window, Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // 7. رابط تسجيل الدخول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // العودة لشاشة تسجيل الدخول
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: AppTheme.charcoalGray,
                              fontWeight: FontWeight.w700, // Cairo Bold
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'لديك حساب بالفعل؟',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500, // Cairo Medium
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لتنظيم شكل الحقول وضمان وضع الأيقونات على اليسار
  InputDecoration _buildInputDecoration({required String hintText, required IconData leftIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5)),
      // suffixIcon تظهر على اليسار في الوضع العربي RTL
      suffixIcon: Icon(leftIcon, color: Colors.grey), 
    );
  }

  // دالة أزرار التسجيل
  Widget _buildSocialButton(String text, IconData icon, Color iconColor, {double iconSize = 22}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.charcoalGray),
          ),
        ],
      ),
    );
  }
}