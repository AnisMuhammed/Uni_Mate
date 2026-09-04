// lib/screens/courses/courses_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../course_details/course_details_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.coursesTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: textColor)),
                      Text(loc.coursesSubtitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: secondaryTextColor)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle, border: Border.all(color: borderColor)),
                    child: Icon(Icons.filter_list, color: textColor, size: 22),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _searchController,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: loc.searchCourse,
                  hintStyle: TextStyle(color: secondaryTextColor, fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: cardColor, 
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppTheme.warmOrange, width: 1.5)),
                  prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.coursesList, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: isDark ? borderColor : Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                    child: Text('3', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: secondaryTextColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  _buildCourseCard(context, 'Web Development', '4', '3', 0.75, Icons.language, Colors.blue.shade300, cardColor, textColor, secondaryTextColor, borderColor, isDark, loc, isRtl),
                  const SizedBox(height: 16),
                  _buildCourseCard(context, 'Database Management', '6', '2', 0.55, Icons.storage, Colors.red.shade300, cardColor, textColor, secondaryTextColor, borderColor, isDark, loc, isRtl),
                  const SizedBox(height: 16),
                  _buildCourseCard(context, 'Computer Networks', '5', '2', 0.68, Icons.hub_outlined, Colors.amber, cardColor, textColor, secondaryTextColor, borderColor, isDark, loc, isRtl),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, String title, String lecturesCount, String tasksCount, double progress, IconData icon, Color iconColor, Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark, AppLocalizations loc, bool isRtl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.menu_book_outlined, size: 14, color: secColor),
                        const SizedBox(width: 4),
                        Text('$lecturesCount', style: TextStyle(fontSize: 12, color: secColor, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 12),
                        Icon(Icons.assignment_outlined, size: 14, color: secColor),
                        const SizedBox(width: 4),
                        Text('$tasksCount', style: TextStyle(fontSize: 12, color: secColor, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.academicProgress, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: secColor)),
              Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: isDark ? borderColor : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.white : AppTheme.charcoalGray), 
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsScreen(courseName: title))),
              style: TextButton.styleFrom(backgroundColor: isDark ? borderColor : Colors.grey.shade100, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isRtl ? Icons.arrow_back : Icons.arrow_forward, size: 18, color: textColor), 
                  const SizedBox(width: 8),
                  Text(loc.viewDetails, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}