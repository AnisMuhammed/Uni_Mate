// lib/screens/course_details/course_details_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseName;
  const CourseDetailsScreen({Key? key, required this.courseName}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int _selectedTab = 2; // 0: المحاضرات, 1: المهام, 2: المراجع

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final borderColor = Theme.of(context).dividerColor;

    final loc = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(loc.courseDetailsTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildCourseHeader(cardColor, textColor, secondaryTextColor, borderColor, isDark, loc),
            const SizedBox(height: 24),
            _buildTabBar(cardColor, textColor, borderColor, loc),
            const SizedBox(height: 24),
            // هنا نعرض محتوى "المراجع" كونه التبويب المحدد افتراضياً في صورتك
            _buildReferenceItem('React Official Docs', loc.externalLink, Icons.link, cardColor, textColor, secondaryTextColor, borderColor, isRtl),
            const SizedBox(height: 12),
            _buildReferenceItem('Chapter 1 Slides', 'PDF', Icons.picture_as_pdf, cardColor, textColor, secondaryTextColor, borderColor, isRtl),
            const SizedBox(height: 12),
            _buildReferenceItem('Project Template', 'ZIP', Icons.folder_zip_outlined, cardColor, textColor, secondaryTextColor, borderColor, isRtl),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader(Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: borderColor), boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isDark ? borderColor : Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                child: Text('IT 301', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textColor)),
              ),
              const Icon(Icons.language, color: Colors.blue, size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Text(widget.courseName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: secColor),
              const SizedBox(width: 4),
              Text(loc.announcementSender.replaceAll('من: ', ''), style: TextStyle(fontSize: 13, color: secColor, fontWeight: FontWeight.w500)),
              const SizedBox(width: 12),
              Text('•', style: TextStyle(color: secColor)),
              const SizedBox(width: 12),
              Text('3 ${loc.creditHours}', style: TextStyle(fontSize: 13, color: secColor, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.completionRate, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: secColor)),
              const Text('75%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 6,
              backgroundColor: isDark ? borderColor : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.white : AppTheme.charcoalGray),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(Color cardColor, Color textColor, Color borderColor, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(child: _buildTabButton(loc.lecture, 0, textColor)),
          Expanded(child: _buildTabButton(loc.tasksTitle, 1, textColor)),
          Expanded(child: _buildTabButton(loc.references, 2, textColor)),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index, Color textColor) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: isSelected ? AppTheme.warmOrange : Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : textColor)),
        ),
      ),
    );
  }

  Widget _buildReferenceItem(String title, String subtitle, IconData icon, Color cardColor, Color textColor, Color secColor, Color borderColor, bool isRtl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.warmOrange, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 12, color: secColor)),
              ],
            ),
          ),
          Icon(Icons.download_outlined, color: secColor, size: 20),
        ],
      ),
    );
  }
}