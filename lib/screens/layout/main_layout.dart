// lib/screens/layout/main_layout.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart'; 
import '../home/home_screen.dart';
import '../schedule/schedule_screen.dart';
import '../courses/courses_screen.dart';
import '../profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const CoursesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final unselectedColor = Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5);
    final loc = AppLocalizations.of(context)!;

    // تم حذف Directionality من هنا ليتفاعل مع اللغة
    return Scaffold(
      backgroundColor: bgColor, 
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: cardColor, 
            selectedItemColor: AppTheme.warmOrange,
            unselectedItemColor: unselectedColor, 
            selectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500, fontSize: 12),
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: loc.home),
              BottomNavigationBarItem(icon: const Icon(Icons.calendar_today_outlined), activeIcon: const Icon(Icons.calendar_month), label: loc.schedule),
              BottomNavigationBarItem(icon: const Icon(Icons.book_outlined), activeIcon: const Icon(Icons.book), label: loc.courses),
              BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: loc.profile),
            ],
          ),
        ),
      ),
    );
  }
}