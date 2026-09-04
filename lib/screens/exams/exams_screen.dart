// lib/screens/exams/exams_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  int _selectedTab = 1;

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
        title: Text(loc.examsTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: textColor), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.yourExams, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: textColor)),
                    const SizedBox(height: 4),
                    Text(loc.trackExams, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: secondaryTextColor)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppTheme.warmOrange.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.emoji_events_outlined, color: AppTheme.warmOrange, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
              child: Row(
                children: [
                  Expanded(child: _buildTabButton(loc.previous, 0, textColor)),
                  Expanded(child: _buildTabButton(loc.upcoming, 1, textColor)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.upcomingExamsTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor)),
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppTheme.warmOrange, size: 18),
                    const SizedBox(width: 4),
                    Text(loc.watchDeadlines, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.warmOrange.withOpacity(0.9))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildExamCard('Database Management', 'Database Quiz', 'أغسطس 28', 'صباحا 10:00', 'يبدأ بعد 8 أيام', cardColor, textColor, secondaryTextColor, borderColor, loc, isRtl),
            const SizedBox(height: 24),

            _buildAdviceCard(cardColor, textColor, secondaryTextColor, borderColor, isDark, loc, isRtl),
          ],
        ),
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
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : textColor)),
            if (isSelected) const SizedBox(height: 2),
            if (isSelected) Text('1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(String courseName, String examTitle, String date, String time, String countdown, Color cardColor, Color textColor, Color secColor, Color borderColor, AppLocalizations loc, bool isRtl) {
    return Container(
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: AppTheme.warmOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(Icons.schedule, size: 14, color: AppTheme.warmOrange),
                              const SizedBox(width: 4),
                              Text(countdown, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(courseName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secColor)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.circular(6)),
                              child: Icon(Icons.menu_book_outlined, size: 14, color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(examTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
                    const SizedBox(height: 16),
                    Divider(height: 1, color: borderColor),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios, size: 12, color: AppTheme.warmOrange),
                            const SizedBox(width: 4),
                            Text(loc.details, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.warmOrange)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(date, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor)),
                                const SizedBox(width: 6),
                                const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.blue),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(time, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: secColor)),
                                const SizedBox(width: 6),
                                const Icon(Icons.access_time, size: 14, color: Colors.blue),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 5, decoration: BoxDecoration(color: AppTheme.warmOrange, borderRadius: BorderRadius.only(
              topLeft: isRtl ? const Radius.circular(16) : Radius.zero, 
              bottomLeft: isRtl ? const Radius.circular(16) : Radius.zero,
              topRight: isRtl ? Radius.zero : const Radius.circular(16),
              bottomRight: isRtl ? Radius.zero : const Radius.circular(16),
            ))),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceCard(Color cardColor, Color textColor, Color secColor, Color borderColor, bool isDark, AppLocalizations loc, bool isRtl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? borderColor : Colors.blue.withOpacity(0.03), borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? borderColor : Colors.blue.withOpacity(0.1))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.academicAdvice, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textColor)),
                    const SizedBox(height: 6),
                    Text(loc.reviewAdvice, style: TextStyle(fontSize: 13, color: secColor, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppTheme.warmOrange.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.emoji_objects_outlined, color: AppTheme.warmOrange, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(backgroundColor: isDark ? cardColor : Colors.grey.shade200, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isRtl ? Icons.arrow_back : Icons.arrow_forward, size: 16, color: textColor),
                  const SizedBox(width: 8),
                  Text(loc.browseStudyResources, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}