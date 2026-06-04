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
/// import 'gen/app_localizations.dart';
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

  /// No description provided for @homeMiddaySet.
  ///
  /// In tr, this message translates to:
  /// **'Öğle Seti'**
  String get homeMiddaySet;

  /// No description provided for @homeStartSession.
  ///
  /// In tr, this message translates to:
  /// **'Antrenmana Başla'**
  String get homeStartSession;

  /// No description provided for @homeLongestStreak.
  ///
  /// In tr, this message translates to:
  /// **'En uzun seri: {count} gün'**
  String homeLongestStreak(int count);

  /// No description provided for @homeMorningDone.
  ///
  /// In tr, this message translates to:
  /// **'☀️ Sabah tamamlandı!'**
  String get homeMorningDone;

  /// No description provided for @homeDayComplete.
  ///
  /// In tr, this message translates to:
  /// **'🎉 Bugün tamamlandı!'**
  String get homeDayComplete;

  /// No description provided for @homeExerciseSummary.
  ///
  /// In tr, this message translates to:
  /// **'{sets} set × {reps} tekrar'**
  String homeExerciseSummary(int sets, int reps);

  /// No description provided for @homeHoldSeconds.
  ///
  /// In tr, this message translates to:
  /// **'{seconds} sn tutuş'**
  String homeHoldSeconds(int seconds);

  /// No description provided for @homeWeekProgress.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta: {done}/{total} egzersiz'**
  String homeWeekProgress(int done, int total);

  /// No description provided for @homeNoExercises.
  ///
  /// In tr, this message translates to:
  /// **'Bugün için egzersiz yok'**
  String get homeNoExercises;

  /// No description provided for @homeNoProgram.
  ///
  /// In tr, this message translates to:
  /// **'Etkin program yok'**
  String get homeNoProgram;

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

  /// No description provided for @sessionSetProgress.
  ///
  /// In tr, this message translates to:
  /// **'{current} / {total} set'**
  String sessionSetProgress(int current, int total);

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

  /// No description provided for @sessionSkip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get sessionSkip;

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

  /// No description provided for @sessionCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı!'**
  String get sessionCompleted;

  /// No description provided for @sessionExitTitle.
  ///
  /// In tr, this message translates to:
  /// **'Antrenmandan çık?'**
  String get sessionExitTitle;

  /// No description provided for @sessionExitMessage.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemen kaydedilmeyecek.'**
  String get sessionExitMessage;

  /// No description provided for @sessionExitConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Çık'**
  String get sessionExitConfirm;

  /// No description provided for @sessionMute.
  ///
  /// In tr, this message translates to:
  /// **'Sesi kapat'**
  String get sessionMute;

  /// No description provided for @sessionUnmute.
  ///
  /// In tr, this message translates to:
  /// **'Sesi aç'**
  String get sessionUnmute;

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

  /// No description provided for @progressTotalCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlanan'**
  String get progressTotalCompleted;

  /// No description provided for @progressCurrentStreak.
  ///
  /// In tr, this message translates to:
  /// **'Güncel seri'**
  String get progressCurrentStreak;

  /// No description provided for @progressLongestStreak.
  ///
  /// In tr, this message translates to:
  /// **'En uzun seri'**
  String get progressLongestStreak;

  /// No description provided for @progressCompletion.
  ///
  /// In tr, this message translates to:
  /// **'Program ilerlemesi'**
  String get progressCompletion;

  /// No description provided for @progressWeeklyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık tamamlanma'**
  String get progressWeeklyTitle;

  /// No description provided for @progressActivityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite (son 3 ay)'**
  String get progressActivityTitle;

  /// No description provided for @progressBadgesSummary.
  ///
  /// In tr, this message translates to:
  /// **'{unlocked}/{total} başarım'**
  String progressBadgesSummary(int unlocked, int total);

  /// No description provided for @progressWeekDays.
  ///
  /// In tr, this message translates to:
  /// **'{count} gün'**
  String progressWeekDays(int count);

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

  /// No description provided for @settingsNotifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get settingsNotifications;

  /// No description provided for @settingsMorningReminder.
  ///
  /// In tr, this message translates to:
  /// **'Sabah Hatırlatıcısı'**
  String get settingsMorningReminder;

  /// No description provided for @settingsEveningReminder.
  ///
  /// In tr, this message translates to:
  /// **'Akşam Hatırlatıcısı'**
  String get settingsEveningReminder;

  /// No description provided for @settingsWeeklySummaryHint.
  ///
  /// In tr, this message translates to:
  /// **'Her Pazar akşamı gönderilir'**
  String get settingsWeeklySummaryHint;

  /// No description provided for @settingsTestNotification.
  ///
  /// In tr, this message translates to:
  /// **'Test Bildirimi Gönder'**
  String get settingsTestNotification;

  /// No description provided for @settingsTestSent.
  ///
  /// In tr, this message translates to:
  /// **'Test bildirimi gönderildi'**
  String get settingsTestSent;

  /// No description provided for @settingsAppearance.
  ///
  /// In tr, this message translates to:
  /// **'Görünüm'**
  String get settingsAppearance;

  /// No description provided for @settingsProgramSection.
  ///
  /// In tr, this message translates to:
  /// **'Program'**
  String get settingsProgramSection;

  /// No description provided for @settingsLevelSystem.
  ///
  /// In tr, this message translates to:
  /// **'Seviye sistemi'**
  String get settingsLevelSystem;

  /// No description provided for @settingsLevelSystemHint.
  ///
  /// In tr, this message translates to:
  /// **'Haftalar önceki hafta %70 tamamlanınca açılır'**
  String get settingsLevelSystemHint;

  /// No description provided for @settingsResetProgress.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi Sıfırla'**
  String get settingsResetProgress;

  /// No description provided for @settingsResetProgressConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Tüm tamamlama kayıtların silinecek. Emin misin?'**
  String get settingsResetProgressConfirm;

  /// No description provided for @settingsDeleteAll.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Verileri Sil'**
  String get settingsDeleteAll;

  /// No description provided for @settingsDeleteAllConfirm1.
  ///
  /// In tr, this message translates to:
  /// **'Tüm özel programlar, kayıtlar ve başarımlar silinecek.'**
  String get settingsDeleteAllConfirm1;

  /// No description provided for @settingsDeleteAllConfirm2.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz. Devam edilsin mi?'**
  String get settingsDeleteAllConfirm2;

  /// No description provided for @settingsAbout.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm'**
  String get settingsVersion;

  /// No description provided for @settingsHowToUse.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl Kullanılır?'**
  String get settingsHowToUse;

  /// No description provided for @testNotificationTitle.
  ///
  /// In tr, this message translates to:
  /// **'Test 🔔'**
  String get testNotificationTitle;

  /// No description provided for @testNotificationBody.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler düzgün çalışıyor!'**
  String get testNotificationBody;

  /// No description provided for @programCreateNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Program Oluştur'**
  String get programCreateNew;

  /// No description provided for @programNamePrompt.
  ///
  /// In tr, this message translates to:
  /// **'Program adı'**
  String get programNamePrompt;

  /// No description provided for @programResetDefault.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılana Sıfırla'**
  String get programResetDefault;

  /// No description provided for @programResetDefaultConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan program ilk haline döndürülecek. Devam edilsin mi?'**
  String get programResetDefaultConfirm;

  /// No description provided for @programActiveChip.
  ///
  /// In tr, this message translates to:
  /// **'Etkin'**
  String get programActiveChip;

  /// No description provided for @programAddWeek.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Hafta Ekle'**
  String get programAddWeek;

  /// No description provided for @programAddExercise.
  ///
  /// In tr, this message translates to:
  /// **'Egzersiz Ekle'**
  String get programAddExercise;

  /// No description provided for @programDeleteExerciseConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bu egzersiz silinsin mi?'**
  String get programDeleteExerciseConfirm;

  /// No description provided for @programDeleteWeekConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta ve tüm egzersizleri silinsin mi?'**
  String get programDeleteWeekConfirm;

  /// No description provided for @programForceUnlockTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftayı Zorla Aç'**
  String get programForceUnlockTitle;

  /// No description provided for @programForceUnlockExplain.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta normalde önceki haftanın %70\'i tamamlanınca açılır. Yine de şimdi açmak istiyor musun?'**
  String get programForceUnlockExplain;

  /// No description provided for @programDayMorning.
  ///
  /// In tr, this message translates to:
  /// **'Sabah'**
  String get programDayMorning;

  /// No description provided for @programDayMidday.
  ///
  /// In tr, this message translates to:
  /// **'Öğle'**
  String get programDayMidday;

  /// No description provided for @programDayEvening.
  ///
  /// In tr, this message translates to:
  /// **'Akşam'**
  String get programDayEvening;

  /// No description provided for @exerciseName.
  ///
  /// In tr, this message translates to:
  /// **'Egzersiz adı'**
  String get exerciseName;

  /// No description provided for @exerciseType.
  ///
  /// In tr, this message translates to:
  /// **'Tür'**
  String get exerciseType;

  /// No description provided for @exerciseTypeKegel.
  ///
  /// In tr, this message translates to:
  /// **'Kegel'**
  String get exerciseTypeKegel;

  /// No description provided for @exerciseTypeBreath.
  ///
  /// In tr, this message translates to:
  /// **'Nefes'**
  String get exerciseTypeBreath;

  /// No description provided for @exerciseTypeMind.
  ///
  /// In tr, this message translates to:
  /// **'Zihin'**
  String get exerciseTypeMind;

  /// No description provided for @exerciseTypeCombo.
  ///
  /// In tr, this message translates to:
  /// **'Kombo'**
  String get exerciseTypeCombo;

  /// No description provided for @exerciseSets.
  ///
  /// In tr, this message translates to:
  /// **'Set'**
  String get exerciseSets;

  /// No description provided for @exerciseReps.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar'**
  String get exerciseReps;

  /// No description provided for @exerciseHold.
  ///
  /// In tr, this message translates to:
  /// **'Tutma süresi: {seconds} sn'**
  String exerciseHold(int seconds);

  /// No description provided for @exerciseRest.
  ///
  /// In tr, this message translates to:
  /// **'Dinlenme: {seconds} sn'**
  String exerciseRest(int seconds);

  /// No description provided for @exerciseDescription.
  ///
  /// In tr, this message translates to:
  /// **'Açıklama'**
  String get exerciseDescription;

  /// No description provided for @exerciseSteps.
  ///
  /// In tr, this message translates to:
  /// **'Adımlar'**
  String get exerciseSteps;

  /// No description provided for @exerciseAddStep.
  ///
  /// In tr, this message translates to:
  /// **'Adım Ekle'**
  String get exerciseAddStep;

  /// No description provided for @exerciseStepHint.
  ///
  /// In tr, this message translates to:
  /// **'{number}. adım'**
  String exerciseStepHint(int number);

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

  /// No description provided for @commonReset.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırla'**
  String get commonReset;

  /// No description provided for @commonContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get commonContinue;

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @errorGeneric.
  ///
  /// In tr, this message translates to:
  /// **'Bir şeyler ters gitti'**
  String get errorGeneric;

  /// No description provided for @errorRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get errorRetry;

  /// No description provided for @badgeUnlockedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Başarım! 🎉'**
  String get badgeUnlockedTitle;

  /// No description provided for @badgeUnlockedSnack.
  ///
  /// In tr, this message translates to:
  /// **'Başarım kazanıldı: {name}'**
  String badgeUnlockedSnack(String name);

  /// No description provided for @onboardingSkip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get onboardingSkip;

  /// No description provided for @onboardingTitle1.
  ///
  /// In tr, this message translates to:
  /// **'Pelvik Tabanını Güçlendir'**
  String get onboardingTitle1;

  /// No description provided for @onboardingBody1.
  ///
  /// In tr, this message translates to:
  /// **'Bu 8 haftalık program, pelvik taban kaslarını kademeli olarak güçlendirmen için günlük kısa egzersizler sunar. Düzenli pratikle kontrol ve dayanıklılık kazanırsın.'**
  String get onboardingBody1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl Çalışır?'**
  String get onboardingTitle2;

  /// No description provided for @onboardingStep1.
  ///
  /// In tr, this message translates to:
  /// **'Her gün sabah ve akşam kısa setleri tamamla.'**
  String get onboardingStep1;

  /// No description provided for @onboardingStep2.
  ///
  /// In tr, this message translates to:
  /// **'Rehberli zamanlayıcı kas, tut, bırak ve dinlen fazlarında sana eşlik eder.'**
  String get onboardingStep2;

  /// No description provided for @onboardingStep3.
  ///
  /// In tr, this message translates to:
  /// **'Serini sürdür, başarımların kilidini aç ve ilerlemeni izle.'**
  String get onboardingStep3;

  /// No description provided for @onboardingTitle3.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlatıcıları Aç'**
  String get onboardingTitle3;

  /// No description provided for @onboardingBody3.
  ///
  /// In tr, this message translates to:
  /// **'Egzersizi unutmamak için günlük hatırlatma saatlerini seç. Bunları daha sonra Ayarlar\'dan değiştirebilirsin.'**
  String get onboardingBody3;

  /// No description provided for @onboardingMorning.
  ///
  /// In tr, this message translates to:
  /// **'Sabah hatırlatıcısı'**
  String get onboardingMorning;

  /// No description provided for @onboardingEvening.
  ///
  /// In tr, this message translates to:
  /// **'Akşam hatırlatıcısı'**
  String get onboardingEvening;

  /// No description provided for @onboardingNext.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get onboardingNext;

  /// No description provided for @onboardingFinish.
  ///
  /// In tr, this message translates to:
  /// **'Başla'**
  String get onboardingFinish;
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
