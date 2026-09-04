// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../tasks/tasks_screen.dart'; 
import '../exams/exams_screen.dart'; 
import '../grades/grades_screen.dart'; 
import '../announcements/announcements_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // === استدعاء الألوان الديناميكية من الثيم ===
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final borderColor = Theme.of(context).dividerColor;
    final loc = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: bgColor, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مررنا الـ context هنا
              _buildHeader(context, textColor, secondaryTextColor, cardColor, borderColor),
              const SizedBox(height: 24),

              // استبدلنا النصوص الثابتة بالقاموس
              _buildSectionTitle(context, loc.upcomingLecture, trailingText: loc.startsIn, isAlert: true, textColor: textColor),
              const SizedBox(height: 12),
              _buildUpcomingLectureCard(cardColor, textColor, secondaryTextColor, borderColor),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // استبدلنا النصوص الثابتة بالقاموس
                  _buildStatCard(context, loc.examsCount, '2', Icons.assignment_turned_in_outlined, cardColor, textColor, secondaryTextColor, borderColor, const ExamsScreen()),
                  _buildStatCard(context, loc.tasksCount, '3', Icons.assignment_outlined, cardColor, textColor, secondaryTextColor, borderColor, const TasksScreen()),
                  _buildStatCard(context, loc.coursesCount, '6', Icons.menu_book_outlined, cardColor, textColor, secondaryTextColor, borderColor, null),
                ],
              ),
              const SizedBox(height: 24),

              _buildProgressSection(context, cardColor, textColor, secondaryTextColor, borderColor, isDark),
              const SizedBox(height: 24),

              // استبدلنا النصوص الثابتة بالقاموس
              _buildSectionTitle(context, loc.upcomingTasks, trailingText: loc.viewAllTasks, isAlert: false, textColor: textColor, targetScreen: const TasksScreen()),
              const SizedBox(height: 12),
              _buildTaskCard('Database Assignment', 'غداً، 11:59 م', Icons.storage, cardColor, textColor, secondaryTextColor, borderColor, isDark),
              const SizedBox(height: 12),
              _buildTaskCard('Web Development Project', 'أغسطس 20', Icons.web, cardColor, textColor, secondaryTextColor, borderColor, isDark),
              const SizedBox(height: 24),

              _buildAnnouncementCard(context, isDark),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- دوال بناء واجهة المستخدم (محدثة لتقبل الألوان الديناميكية) ---

  // أضفنا BuildContext context هنا
  Widget _buildHeader(BuildContext context, Color textColor, Color secColor, Color cardColor, Color borderColor) {
    // عرفنا القاموس
    final loc = AppLocalizations.of(context)!;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 24, backgroundColor: Colors.grey.shade300, backgroundImage: const NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png')),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.goodMorning, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
                Text(loc.readyForNewDay, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: secColor)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(loc.today, style: TextStyle(fontSize: 11, color: secColor, fontWeight: FontWeight.w500)),
                Text(loc.august20, style: TextStyle(fontSize: 13, color: textColor.withOpacity(0.8), fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle, border: Border.all(color: borderColor)),
              child: Icon(Icons.notifications_none_outlined, color: textColor, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {required String trailingText, required bool isAlert, Widget? targetScreen, required Color textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
        GestureDetector(
          onTap: () {
            if (targetScreen != null) Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: isAlert ? AppTheme.warmOrange.withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
            child: Text(trailingText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.warmOrange)),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingLectureCard(Color cardColor, Color textColor, Color secColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.warmOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.computer, color: AppTheme.warmOrange, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Computer Networks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: secColor),
                    const SizedBox(width: 4),
                    Text('Lab 204', style: TextStyle(fontSize: 13, color: secColor, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time_outlined, size: 14, color: secColor),
                    const SizedBox(width: 4),
                    Text('10:00 AM', style: TextStyle(fontSize: 13, color: secColor, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String count, IconData icon, Color cardColor, Color textColor, Color secColor, Color borderColor, Widget? targetScreen) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (targetScreen != null) Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.warmOrange, size: 24),
              const SizedBox(height: 8),
              Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
              Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark) { 
    // عرفنا القاموس
    final loc = AppLocalizations.of(context)!;
    
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GradesScreen())),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.academicProgress, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textColor)),
                const Text('75%', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.75,
                minHeight: 8,
                backgroundColor: isDark ? const Color(0xFF3A3A3C) : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.white : AppTheme.charcoalGray), 
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 8),
                    Text(loc.performanceExcellent, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secColor)),
                  ],
                ),
                Icon(Icons.arrow_back_ios, size: 12, color: secColor), 
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(String title, String time, IconData icon, Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: textColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor)),
                const SizedBox(height: 4),
                Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secColor)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: secColor),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, bool isDark) {
    // عرفنا القاموس
    final loc = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : AppTheme.charcoalGray, 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.campaign_outlined, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(loc.latestAnnouncement, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.9))),
                ],
              ),
              Text(loc.august20, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7))),
            ],
          ),
          // داخل دالة _buildAnnouncementCard
          const SizedBox(height: 12),
          Text(loc.announcementPostponed, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)), // التعديل هنا
          const SizedBox(height: 4),
          Text(loc.announcementSender, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7))), // والتعديل هنا
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnouncementsScreen())),
              child: Text(loc.viewMore, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
            ),
          ),
        ],
      ),
    );
  }
}