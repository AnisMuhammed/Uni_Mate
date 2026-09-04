// lib/screens/announcements/announcements_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  int _selectedFilter = 0;

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
        title: Text(loc.announcementsTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildFilterChip(loc.all, 0, cardColor, textColor, borderColor),
                const SizedBox(width: 8),
                _buildFilterChip(loc.academic, 1, cardColor, textColor, borderColor),
                const SizedBox(width: 8),
                _buildFilterChip(loc.urgent, 2, cardColor, textColor, borderColor),
                const SizedBox(width: 8),
                _buildFilterChip(loc.general, 3, cardColor, textColor, borderColor),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                _buildAnnouncementCard(
                  title: isRtl ? 'تأجيل محاضرة قواعد البيانات' : 'Database Lecture Postponed',
                  sender: isRtl ? 'د. بديع - كلية تقنية المعلومات' : 'Dr. Badi - IT Faculty',
                  date: isRtl ? 'اليوم، 09:30 ص' : 'Today, 09:30 AM',
                  content: isRtl 
                    ? 'نظراً لظروف طارئة، سيتم تأجيل محاضرة قواعد البيانات المقررة اليوم إلى يوم الخميس القادم في نفس الموعد. نرجو من الجميع الالتزام.'
                    : 'Due to unforeseen circumstances, today\'s Database lecture has been postponed to next Thursday at the same time. Please adhere to this change.',
                  isUrgent: true,
                  cardColor: cardColor,
                  textColor: textColor,
                  secColor: secondaryTextColor,
                  borderColor: borderColor,
                  isDark: isDark,
                  loc: loc,
                  isRtl: isRtl,
                ),
                const SizedBox(height: 16),
                _buildAnnouncementCard(
                  title: isRtl ? 'بدء التسجيل للفصل الدراسي القادم' : 'Registration Open for Next Semester',
                  sender: isRtl ? 'عمادة القبول والتسجيل' : 'Deanship of Admission',
                  date: isRtl ? 'أغسطس 18' : 'Aug 18',
                  content: isRtl
                    ? 'نلفت انتباه جميع الطلاب بأن بوابة التسجيل للفصل الدراسي القادم ستفتح يوم الأحد القادم. يرجى مراجعة المرشد الأكاديمي لتسجيل المواد.'
                    : 'Attention all students: Registration for the upcoming semester opens next Sunday. Please consult your academic advisor.',
                  isUrgent: false,
                  cardColor: cardColor,
                  textColor: textColor,
                  secColor: secondaryTextColor,
                  borderColor: borderColor,
                  isDark: isDark,
                  loc: loc,
                  isRtl: isRtl,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String title, int index, Color cardColor, Color textColor, Color borderColor) {
    bool isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.warmOrange : cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppTheme.warmOrange : borderColor),
        ),
        child: Text(title, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : textColor)),
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required String title,
    required String sender,
    required String date,
    required String content,
    required bool isUrgent,
    required Color cardColor,
    required Color textColor,
    required Color secColor,
    required Color borderColor,
    required bool isDark,
    required AppLocalizations loc,
    required bool isRtl,
  }) {
    return Container(
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor), boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: isUrgent ? const Color(0xFFE65150) : (isDark ? AppTheme.warmOrange : AppTheme.charcoalGray),
                borderRadius: BorderRadius.only(
                  topRight: isRtl ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isRtl ? const Radius.circular(16) : Radius.zero,
                  topLeft: isRtl ? Radius.zero : const Radius.circular(16),
                  bottomLeft: isRtl ? Radius.zero : const Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 14, color: secColor),
                            const SizedBox(width: 6),
                            Text(sender, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: secColor)),
                          ],
                        ),
                        Text(date, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: secColor.withOpacity(0.8))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (isUrgent) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: const Color(0xFFE65150).withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                            child: Text(loc.urgent, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFE65150))),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(content, style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFFC4CDD5) : Colors.grey.shade700, height: 1.6)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}