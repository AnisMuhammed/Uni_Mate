// lib/widgets/app_logo.dart
import 'package:flutter/material.dart';

/// شعار التطبيق الرسمي (assets/icon/app_icon.png)
///
/// نلفّه بـ ClipRRect حتى لا تظهر أي حواف من الصورة الأصلية
/// مهما كان مقاس العرض المطلوب.
class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.size = 80, this.borderRadius}) : super(key: key);

  /// طول وعرض الشعار (مربع)
  final double size;

  /// نصف قطر الحواف — افتراضياً مشتق من المقاس ليبقى متناسقاً
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? size * 0.24),
      child: Image.asset(
        'assets/icon/app_icon.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
