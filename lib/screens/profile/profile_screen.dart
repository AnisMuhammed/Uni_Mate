// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../main.dart'; // للوصول لـ localeNotifier و themeNotifier

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final borderColor = Theme.of(context).dividerColor;

    // قراءة اللغة الحالية
    final isArabic = localeNotifier.value.languageCode == 'ar';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Text(isArabic ? 'الملف الشخصي' : 'Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
              const SizedBox(height: 24),
              
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png')),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
                    child: const Icon(Icons.fingerprint, color: AppTheme.warmOrange, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // جلبنا الاسم من التفضيلات المحفوظة
              Text(isArabic ? 'أنيس محمد' : 'Anis Mohammed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
              Text('Information Technology • Level 4', style: TextStyle(fontSize: 13, color: secondaryTextColor)),
              const SizedBox(height: 24),

              Row(
                children: [
                  _buildStatItem('12', isArabic ? 'تنبيه' : 'Alerts', textColor, secondaryTextColor),
                  _buildStatItem('96', isArabic ? 'ساعة' : 'Hours', textColor, secondaryTextColor),
                  _buildStatItem('3.72', isArabic ? 'المعدل' : 'GPA', textColor, secondaryTextColor),
                ],
              ),
              const SizedBox(height: 32),

              _buildSettingItem(Icons.person_outline, isArabic ? 'المعلومات الشخصية' : 'Personal Info', cardColor, textColor, borderColor),
              _buildSettingItem(Icons.notifications_none, isArabic ? 'الإشعارات' : 'Notifications', cardColor, textColor, borderColor, trailingText: '3'),
              
              // === زر تبديل اللغة ===
              _buildSettingItem(
                Icons.language, 
                isArabic ? 'اللغة' : 'Language', 
                cardColor, 
                textColor, 
                borderColor, 
                trailingText: isArabic ? 'العربية' : 'English',
                onTap: () {
                  // هنا يتم تغيير اللغة بثانية واحدة
                  localeNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
                }
              ),
              
              // === زر تبديل الوضع الغامق والفاتح ===
              _buildThemeToggleItem(cardColor, textColor, borderColor, isDark, isArabic),
              
              _buildSettingItem(Icons.shield_outlined, isArabic ? 'الخصوصية' : 'Privacy', cardColor, textColor, borderColor),
              _buildSettingItem(Icons.settings_outlined, isArabic ? 'الإعدادات' : 'Settings', cardColor, textColor, borderColor),
              
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2E) : AppTheme.charcoalGray.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, color: isDark ? AppTheme.warmOrange : AppTheme.charcoalGray),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isArabic ? 'تأكد من تحديث بريدك لتأمين حسابك الأكاديمي.' : 'Update your email to secure your academic account.', 
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textColor)
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text(isArabic ? 'تحديث' : 'Update', style: const TextStyle(color: AppTheme.warmOrange, fontWeight: FontWeight.w700))),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // زر تسجيل الخروج الثابت
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65150),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(isArabic ? 'تسجيل الخروج' : 'Logout', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String val, String label, Color textColor, Color secondaryColor) {
    return Expanded(
      child: Column(children: [
        Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
        Text(label, style: TextStyle(fontSize: 12, color: secondaryColor)),
      ]),
    );
  }

  // أضفنا onTap هنا لكي يصبح الزر قابلاً للضغط
  Widget _buildSettingItem(IconData icon, String title, Color cardColor, Color textColor, Color borderColor, {String? trailingText, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: textColor)),
            const Spacer(),
            if (trailingText != null) Text(trailingText, style: const TextStyle(color: AppTheme.warmOrange, fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            // الأيقونة تنعكس بناءً على اللغة!
            Icon(Directionality.of(context) == TextDirection.rtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggleItem(Color cardColor, Color textColor, Color borderColor, bool isDark, bool isArabic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: isDark ? AppTheme.warmOrange : Colors.grey),
          const SizedBox(width: 12),
          Text(isArabic ? 'الوضع الغامق' : 'Dark Mode', style: TextStyle(fontWeight: FontWeight.w500, color: textColor)),
          const Spacer(),
          Switch(
            value: isDark,
            activeColor: AppTheme.warmOrange, 
            onChanged: (value) {
              themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
    );
  }
}