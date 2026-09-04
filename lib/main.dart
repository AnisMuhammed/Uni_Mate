// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/generated/app_localizations.dart';
import 'core/app_theme.dart';
import 'screens/splash/splash_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('ar'));

void main() {
  runApp(const UniMateApp());
}

class UniMateApp extends StatelessWidget {
  const UniMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (_, Locale currentLocale, __) {
            return MaterialApp(
              title: 'UniMate',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: currentMode,
              locale: currentLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('ar'), Locale('en')],
              // تم حذف Directionality لكي ينعكس التطبيق تلقائياً مع اللغة
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
