// lib/screens/schedule/schedule_screen.dart
import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDay = 28;

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
                      Text(
                        loc.scheduleTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      Text(
                        loc.scheduleSubtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildIconButton(
                        Icons.calendar_month_outlined,
                        cardColor,
                        textColor,
                        borderColor,
                      ),
                      const SizedBox(width: 12),
                      _buildIconButton(
                        Icons.notifications_none_outlined,
                        cardColor,
                        textColor,
                        borderColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.august20.replaceAll(' 20', ' 2026'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isRtl ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                        size: 14,
                        color: secondaryTextColor,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                        size: 14,
                        color: textColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 85,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildDayCard(
                    loc.sat,
                    26,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                  _buildDayCard(
                    loc.sun,
                    27,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                  _buildDayCard(
                    loc.mon,
                    28,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                  _buildDayCard(
                    loc.tue,
                    29,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                  _buildDayCard(
                    loc.wed,
                    30,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                  _buildDayCard(
                    loc.thu,
                    31,
                    cardColor,
                    textColor,
                    secondaryTextColor,
                    borderColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.todayLectures,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark ? borderColor : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLectureCard(
                      'Web Development',
                      'د. أحمد',
                      'Room 302',
                      '09:00',
                      loc.lecture,
                      false,
                      cardColor,
                      textColor,
                      secondaryTextColor,
                      borderColor,
                      isDark,
                    ),
                    const SizedBox(height: 12),
                    _buildLectureCard(
                      'Database Management',
                      'د. بديع',
                      'Lab 204',
                      '11:00',
                      loc.lab,
                      true,
                      cardColor,
                      textColor,
                      secondaryTextColor,
                      borderColor,
                      isDark,
                    ),
                    const SizedBox(height: 12),
                    _buildLectureCard(
                      'Computer Networks',
                      'د. محمد',
                      'Room 105',
                      '13:00',
                      loc.lecture,
                      false,
                      cardColor,
                      textColor,
                      secondaryTextColor,
                      borderColor,
                      isDark,
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 40,
                            color: isDark ? borderColor : Colors.grey.shade300,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.noMoreLectures,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    Color cardColor,
    Color textColor,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Icon(icon, color: textColor, size: 22),
    );
  }

  Widget _buildDayCard(
    String dayName,
    int dayNumber,
    Color cardColor,
    Color textColor,
    Color secondaryColor,
    Color borderColor,
  ) {
    bool isSelected = _selectedDay == dayNumber;
    return GestureDetector(
      onTap: () => setState(() => _selectedDay = dayNumber),
      child: Container(
        width: 65,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.warmOrange : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.warmOrange : borderColor,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.warmOrange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white.withOpacity(0.9)
                    : secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNumber.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLectureCard(
    String courseName,
    String doctorName,
    String room,
    String time,
    String type,
    bool isLab,
    Color cardColor,
    Color textColor,
    Color secColor,
    Color borderColor,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isLab
                            ? AppTheme.secondaryOrange.withOpacity(0.15)
                            : (isDark ? borderColor : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isLab ? AppTheme.secondaryOrange : secColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        courseName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 16, color: secColor),
                    const SizedBox(width: 4),
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: 13,
                        color: secColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.location_on_outlined, size: 16, color: secColor),
                    const SizedBox(width: 4),
                    Text(
                      room,
                      style: TextStyle(
                        fontSize: 13,
                        color: secColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: borderColor,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Column(
            children: [
              Icon(Icons.access_time, color: secColor, size: 18),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
