// lib/screens/grades/grades_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  int _selectedSemester = 0;

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
        title: Text(loc.gradesAndGpa, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGPACard(cardColor, textColor, loc, secColor: secondaryTextColor, borderColor: borderColor, isDark: isDark),
            const SizedBox(height: 24),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSemesterTab(loc.firstSemester, 0, cardColor, textColor, borderColor),
                  const SizedBox(width: 8),
                  _buildSemesterTab(loc.secondSemester, 1, cardColor, textColor, borderColor),
                  const SizedBox(width: 8),
                  _buildSemesterTab(loc.summerSemester, 2, cardColor, textColor, borderColor),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.academicRecord, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: isDark ? borderColor : Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                  child: Text(isRtl ? '15 ساعة' : '15 Hours', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: secondaryTextColor)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildGradeCard('Web Development', 'IT 301', isRtl ? '3 ساعات' : '3 Hours', 'A+', '98', Colors.green, cardColor, textColor, secondaryTextColor, borderColor, isDark),
            const SizedBox(height: 12),
            _buildGradeCard('Computer Networks', 'IT 305', isRtl ? '3 ساعات' : '3 Hours', 'A', '92', Colors.blue, cardColor, textColor, secondaryTextColor, borderColor, isDark),
            const SizedBox(height: 12),
            _buildGradeCard('Database Management', 'IT 310', isRtl ? '4 ساعات' : '4 Hours', 'B+', '88', AppTheme.warmOrange, cardColor, textColor, secondaryTextColor, borderColor, isDark),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: cardColor, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: borderColor)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.print_outlined, color: textColor, size: 20),
                    const SizedBox(width: 8),
                    Text(loc.printAcademicRecord, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGPACard(Color cardColor, Color textColor, AppLocalizations loc, {required Color secColor, required Color borderColor, required bool isDark}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: isDark ? [] : [BoxShadow(color: AppTheme.warmOrange.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Text(loc.gpa, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: secColor)),
          const SizedBox(height: 12),
          Text('3.72', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.warmOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up, color: AppTheme.warmOrange, size: 18),
                const SizedBox(width: 8),
                Text(loc.excellentPerformance, style: const TextStyle(color: AppTheme.warmOrange, fontWeight: FontWeight.w700, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterTab(String title, int index, Color cardColor, Color textColor, Color borderColor) {
    bool isSelected = _selectedSemester == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedSemester = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.warmOrange : cardColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? AppTheme.warmOrange : borderColor),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildGradeCard(String courseName, String courseCode, String hours, String letterGrade, String numberGrade, Color gradeColor, Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(courseName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: isDark ? borderColor : Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                      child: Text(courseCode, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: secColor)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, size: 14, color: secColor),
                    const SizedBox(width: 4),
                    Text(hours, style: TextStyle(fontSize: 12, color: secColor, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 40, width: 1, color: borderColor, margin: const EdgeInsets.symmetric(horizontal: 16)),
          Column(
            children: [
              Text(letterGrade, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: gradeColor)),
              const SizedBox(height: 2),
              Text('$numberGrade%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}