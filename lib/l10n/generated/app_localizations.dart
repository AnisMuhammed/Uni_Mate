import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'يوني ميت'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get schedule;

  /// No description provided for @courses.
  ///
  /// In ar, this message translates to:
  /// **'المقررات'**
  String get courses;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get profile;

  /// No description provided for @goodMorning.
  ///
  /// In ar, this message translates to:
  /// **'صباح الخير، أنيس'**
  String get goodMorning;

  /// No description provided for @readyForNewDay.
  ///
  /// In ar, this message translates to:
  /// **'جاهز ليوم دراسي جديد؟'**
  String get readyForNewDay;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @august20.
  ///
  /// In ar, this message translates to:
  /// **'أغسطس 20'**
  String get august20;

  /// No description provided for @upcomingLecture.
  ///
  /// In ar, this message translates to:
  /// **'المحاضرة القادمة'**
  String get upcomingLecture;

  /// No description provided for @startsIn.
  ///
  /// In ar, this message translates to:
  /// **'تبدأ بعد 25 دقيقة'**
  String get startsIn;

  /// No description provided for @coursesCount.
  ///
  /// In ar, this message translates to:
  /// **'مواد'**
  String get coursesCount;

  /// No description provided for @tasksCount.
  ///
  /// In ar, this message translates to:
  /// **'مهام'**
  String get tasksCount;

  /// No description provided for @examsCount.
  ///
  /// In ar, this message translates to:
  /// **'اختبارات'**
  String get examsCount;

  /// No description provided for @academicProgress.
  ///
  /// In ar, this message translates to:
  /// **'تقدمك الدراسي'**
  String get academicProgress;

  /// No description provided for @performanceExcellent.
  ///
  /// In ar, this message translates to:
  /// **'أداؤك هذا الفصل ممتاز'**
  String get performanceExcellent;

  /// No description provided for @upcomingTasks.
  ///
  /// In ar, this message translates to:
  /// **'المهام القادمة'**
  String get upcomingTasks;

  /// No description provided for @viewAllTasks.
  ///
  /// In ar, this message translates to:
  /// **'عرض جميع المهام'**
  String get viewAllTasks;

  /// No description provided for @latestAnnouncement.
  ///
  /// In ar, this message translates to:
  /// **'آخر إعلان'**
  String get latestAnnouncement;

  /// No description provided for @announcementPostponed.
  ///
  /// In ar, this message translates to:
  /// **'تأجيل محاضرة قواعد البيانات'**
  String get announcementPostponed;

  /// No description provided for @announcementSender.
  ///
  /// In ar, this message translates to:
  /// **'من: د. محمد سليمان'**
  String get announcementSender;

  /// No description provided for @viewMore.
  ///
  /// In ar, this message translates to:
  /// **'عرض المزيد'**
  String get viewMore;

  /// No description provided for @scheduleTitle.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الدراسي'**
  String get scheduleTitle;

  /// No description provided for @scheduleSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'جدولك الأسبوعي لهذا الفصل'**
  String get scheduleSubtitle;

  /// No description provided for @sat.
  ///
  /// In ar, this message translates to:
  /// **'السبت'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In ar, this message translates to:
  /// **'الأحد'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In ar, this message translates to:
  /// **'الاثنين'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In ar, this message translates to:
  /// **'الثلاثاء'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In ar, this message translates to:
  /// **'الأربعاء'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In ar, this message translates to:
  /// **'الخميس'**
  String get thu;

  /// No description provided for @todayLectures.
  ///
  /// In ar, this message translates to:
  /// **'محاضرات اليوم'**
  String get todayLectures;

  /// No description provided for @noMoreLectures.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد محاضرات إضافية لليوم'**
  String get noMoreLectures;

  /// No description provided for @lecture.
  ///
  /// In ar, this message translates to:
  /// **'محاضرة'**
  String get lecture;

  /// No description provided for @lab.
  ///
  /// In ar, this message translates to:
  /// **'معمل'**
  String get lab;

  /// No description provided for @coursesTitle.
  ///
  /// In ar, this message translates to:
  /// **'المواد الدراسية'**
  String get coursesTitle;

  /// No description provided for @coursesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'جميع موادك الدراسية'**
  String get coursesSubtitle;

  /// No description provided for @searchCourse.
  ///
  /// In ar, this message translates to:
  /// **'البحث عن مادة...'**
  String get searchCourse;

  /// No description provided for @coursesList.
  ///
  /// In ar, this message translates to:
  /// **'قائمة المواد'**
  String get coursesList;

  /// No description provided for @registeredCourses.
  ///
  /// In ar, this message translates to:
  /// **'مواد مسجلة'**
  String get registeredCourses;

  /// No description provided for @viewDetails.
  ///
  /// In ar, this message translates to:
  /// **'عرض التفاصيل'**
  String get viewDetails;

  /// No description provided for @courseDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المادة'**
  String get courseDetailsTitle;

  /// No description provided for @creditHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات معتمدة'**
  String get creditHours;

  /// No description provided for @completionRate.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الإنجاز'**
  String get completionRate;

  /// No description provided for @references.
  ///
  /// In ar, this message translates to:
  /// **'المراجع'**
  String get references;

  /// No description provided for @externalLink.
  ///
  /// In ar, this message translates to:
  /// **'رابط خارجي'**
  String get externalLink;

  /// No description provided for @tasksTitle.
  ///
  /// In ar, this message translates to:
  /// **'المهام'**
  String get tasksTitle;

  /// No description provided for @yourAssignments.
  ///
  /// In ar, this message translates to:
  /// **'واجباتك الدراسية'**
  String get yourAssignments;

  /// No description provided for @trackAssignments.
  ///
  /// In ar, this message translates to:
  /// **'تابع واجباتك ومواعيد التسليم'**
  String get trackAssignments;

  /// No description provided for @searchTask.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مهمة...'**
  String get searchTask;

  /// No description provided for @all.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get all;

  /// No description provided for @upcoming.
  ///
  /// In ar, this message translates to:
  /// **'القادمة'**
  String get upcoming;

  /// No description provided for @completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get completed;

  /// No description provided for @tasksList.
  ///
  /// In ar, this message translates to:
  /// **'قائمة الواجبات'**
  String get tasksList;

  /// No description provided for @celebrateAchievements.
  ///
  /// In ar, this message translates to:
  /// **'احتفل بإنجازاتك!'**
  String get celebrateAchievements;

  /// No description provided for @finishTasksMotivation.
  ///
  /// In ar, this message translates to:
  /// **'أنه مهامك اليوم لترفع معدلك\nالتراكمي وتصل لمرتبة الشرف.'**
  String get finishTasksMotivation;

  /// No description provided for @examsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات'**
  String get examsTitle;

  /// No description provided for @yourExams.
  ///
  /// In ar, this message translates to:
  /// **'اختباراتك'**
  String get yourExams;

  /// No description provided for @trackExams.
  ///
  /// In ar, this message translates to:
  /// **'تابع اختباراتك ونتائجك الأكاديمية بدقة'**
  String get trackExams;

  /// No description provided for @previous.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get previous;

  /// No description provided for @upcomingExamsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات القادمة'**
  String get upcomingExamsTitle;

  /// No description provided for @watchDeadlines.
  ///
  /// In ar, this message translates to:
  /// **'انتبه للمواعيد'**
  String get watchDeadlines;

  /// No description provided for @details.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get details;

  /// No description provided for @academicAdvice.
  ///
  /// In ar, this message translates to:
  /// **'نصيحة أكاديمية'**
  String get academicAdvice;

  /// No description provided for @reviewAdvice.
  ///
  /// In ar, this message translates to:
  /// **'المراجعة المبكرة تساعدك على تذكر المعلومات بنسبة 70% أكثر. ابدأ مراجعة Database Quiz اليوم!'**
  String get reviewAdvice;

  /// No description provided for @browseStudyResources.
  ///
  /// In ar, this message translates to:
  /// **'تصفح مصادر المذاكرة'**
  String get browseStudyResources;

  /// No description provided for @gradesAndGpa.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات والمعدل'**
  String get gradesAndGpa;

  /// No description provided for @gpa.
  ///
  /// In ar, this message translates to:
  /// **'المعدل التراكمي (GPA)'**
  String get gpa;

  /// No description provided for @excellentPerformance.
  ///
  /// In ar, this message translates to:
  /// **'أداؤك ممتاز، استمر!'**
  String get excellentPerformance;

  /// No description provided for @firstSemester.
  ///
  /// In ar, this message translates to:
  /// **'الفصل الأول'**
  String get firstSemester;

  /// No description provided for @secondSemester.
  ///
  /// In ar, this message translates to:
  /// **'الفصل الثاني'**
  String get secondSemester;

  /// No description provided for @summerSemester.
  ///
  /// In ar, this message translates to:
  /// **'الفصل الصيفي'**
  String get summerSemester;

  /// No description provided for @academicRecord.
  ///
  /// In ar, this message translates to:
  /// **'السجل الأكاديمي للفصل'**
  String get academicRecord;

  /// No description provided for @printAcademicRecord.
  ///
  /// In ar, this message translates to:
  /// **'طباعة السجل الأكاديمي'**
  String get printAcademicRecord;

  /// No description provided for @announcementsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعلانات'**
  String get announcementsTitle;

  /// No description provided for @academic.
  ///
  /// In ar, this message translates to:
  /// **'أكاديمي'**
  String get academic;

  /// No description provided for @urgent.
  ///
  /// In ar, this message translates to:
  /// **'عاجل'**
  String get urgent;

  /// No description provided for @general.
  ///
  /// In ar, this message translates to:
  /// **'عام'**
  String get general;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
