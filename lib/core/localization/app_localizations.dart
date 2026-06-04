import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[Locale('tr')];

  /// Application title shown in the task switcher and app bars
  ///
  /// In tr, this message translates to:
  /// **'Pelvik Taban Antrenmanı'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get navHome;

  /// No description provided for @navProgram.
  ///
  /// In tr, this message translates to:
  /// **'Program'**
  String get navProgram;

  /// No description provided for @navProgress.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme'**
  String get navProgress;

  /// No description provided for @navHistory.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş'**
  String get navHistory;

  /// No description provided for @homeTodayTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugünün Setleri'**
  String get homeTodayTitle;

  /// No description provided for @homeStreak.
  ///
  /// In tr, this message translates to:
  /// **'{count} günlük seri'**
  String homeStreak(int count);

  /// No description provided for @homeMorningSet.
  ///
  /// In tr, this message translates to:
  /// **'Sabah Seti'**
  String get homeMorningSet;

  /// No description provided for @homeEveningSet.
  ///
  /// In tr, this message translates to:
  /// **'Akşam Seti'**
  String get homeEveningSet;

  /// No description provided for @homeStartSession.
  ///
  /// In tr, this message translates to:
  /// **'Antrenmana Başla'**
  String get homeStartSession;

  /// No description provided for @sessionPhaseSqueeze.
  ///
  /// In tr, this message translates to:
  /// **'Kas'**
  String get sessionPhaseSqueeze;

  /// No description provided for @sessionPhaseHold.
  ///
  /// In tr, this message translates to:
  /// **'Tut'**
  String get sessionPhaseHold;

  /// No description provided for @sessionPhaseRelease.
  ///
  /// In tr, this message translates to:
  /// **'Bırak'**
  String get sessionPhaseRelease;

  /// No description provided for @sessionPhaseRest.
  ///
  /// In tr, this message translates to:
  /// **'Dinlen'**
  String get sessionPhaseRest;

  /// No description provided for @sessionRepProgress.
  ///
  /// In tr, this message translates to:
  /// **'{current} / {total} tekrar'**
  String sessionRepProgress(int current, int total);

  /// No description provided for @sessionPause.
  ///
  /// In tr, this message translates to:
  /// **'Duraklat'**
  String get sessionPause;

  /// No description provided for @sessionResume.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get sessionResume;

  /// No description provided for @sessionFinish.
  ///
  /// In tr, this message translates to:
  /// **'Bitir'**
  String get sessionFinish;

  /// No description provided for @sessionAbort.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get sessionAbort;

  /// No description provided for @sessionNoteHint.
  ///
  /// In tr, this message translates to:
  /// **'Bu seans için not (isteğe bağlı)'**
  String get sessionNoteHint;

  /// No description provided for @programLocked.
  ///
  /// In tr, this message translates to:
  /// **'Kilitli'**
  String get programLocked;

  /// No description provided for @programUnlockHint.
  ///
  /// In tr, this message translates to:
  /// **'Önceki haftanın %70\'ini tamamla'**
  String get programUnlockHint;

  /// No description provided for @programForceUnlock.
  ///
  /// In tr, this message translates to:
  /// **'Yine de Aç'**
  String get programForceUnlock;

  /// No description provided for @programPhase.
  ///
  /// In tr, this message translates to:
  /// **'{number}. Faz'**
  String programPhase(int number);

  /// No description provided for @programWeek.
  ///
  /// In tr, this message translates to:
  /// **'{number}. Hafta'**
  String programWeek(int number);

  /// No description provided for @achievementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başarımlar'**
  String get achievementsTitle;

  /// No description provided for @achievementLocked.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kazanılmadı'**
  String get achievementLocked;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get settingsThemeDark;

  /// No description provided for @settingsTheme.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsReminders.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlatıcılar'**
  String get settingsReminders;

  /// No description provided for @settingsForceUnlock.
  ///
  /// In tr, this message translates to:
  /// **'Tüm haftaların kilidini aç'**
  String get settingsForceUnlock;

  /// No description provided for @settingsWeeklySummary.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık özet bildirimi'**
  String get settingsWeeklySummary;

  /// No description provided for @remindersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlatıcılar'**
  String get remindersTitle;

  /// No description provided for @remindersAddTime.
  ///
  /// In tr, this message translates to:
  /// **'Saat Ekle'**
  String get remindersAddTime;

  /// No description provided for @remindersDailyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Egzersiz zamanı'**
  String get remindersDailyTitle;

  /// No description provided for @remindersDailyBody.
  ///
  /// In tr, this message translates to:
  /// **'Bugünkü setini tamamlamayı unutma 💪'**
  String get remindersDailyBody;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık Özet'**
  String get weeklySummaryTitle;

  /// No description provided for @weeklySummaryBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta {sessions} seans tamamladın. Harika gidiyorsun!'**
  String weeklySummaryBody(int sessions);

  /// No description provided for @commonSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get commonAdd;

  /// No description provided for @commonEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kayıt yok'**
  String get commonEmpty;
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
      <String>['tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
