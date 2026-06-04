// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Pelvik Taban Antrenmanı';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navProgram => 'Program';

  @override
  String get navProgress => 'İlerleme';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get homeTodayTitle => 'Bugünün Setleri';

  @override
  String homeStreak(int count) {
    return '$count günlük seri';
  }

  @override
  String get homeMorningSet => 'Sabah Seti';

  @override
  String get homeEveningSet => 'Akşam Seti';

  @override
  String get homeMiddaySet => 'Öğle Seti';

  @override
  String get homeStartSession => 'Antrenmana Başla';

  @override
  String homeLongestStreak(int count) {
    return 'En uzun seri: $count gün';
  }

  @override
  String get homeMorningDone => '☀️ Sabah tamamlandı!';

  @override
  String get homeDayComplete => '🎉 Bugün tamamlandı!';

  @override
  String homeExerciseSummary(int sets, int reps) {
    return '$sets set × $reps tekrar';
  }

  @override
  String homeHoldSeconds(int seconds) {
    return '$seconds sn tutuş';
  }

  @override
  String homeWeekProgress(int done, int total) {
    return 'Bu hafta: $done/$total egzersiz';
  }

  @override
  String get homeNoExercises => 'Bugün için egzersiz yok';

  @override
  String get homeNoProgram => 'Etkin program yok';

  @override
  String get sessionPhaseSqueeze => 'Kas';

  @override
  String get sessionPhaseHold => 'Tut';

  @override
  String get sessionPhaseRelease => 'Bırak';

  @override
  String get sessionPhaseRest => 'Dinlen';

  @override
  String sessionRepProgress(int current, int total) {
    return '$current / $total tekrar';
  }

  @override
  String sessionSetProgress(int current, int total) {
    return '$current / $total set';
  }

  @override
  String get sessionPause => 'Duraklat';

  @override
  String get sessionResume => 'Devam Et';

  @override
  String get sessionSkip => 'Atla';

  @override
  String get sessionFinish => 'Bitir';

  @override
  String get sessionAbort => 'İptal';

  @override
  String get sessionCompleted => 'Tamamlandı!';

  @override
  String get sessionExitTitle => 'Antrenmandan çık?';

  @override
  String get sessionExitMessage => 'İlerlemen kaydedilmeyecek.';

  @override
  String get sessionExitConfirm => 'Çık';

  @override
  String get sessionMute => 'Sesi kapat';

  @override
  String get sessionUnmute => 'Sesi aç';

  @override
  String get sessionNoteHint => 'Bu seans için not (isteğe bağlı)';

  @override
  String get programLocked => 'Kilitli';

  @override
  String get programUnlockHint => 'Önceki haftanın %70\'ini tamamla';

  @override
  String get programForceUnlock => 'Yine de Aç';

  @override
  String programPhase(int number) {
    return '$number. Faz';
  }

  @override
  String programWeek(int number) {
    return '$number. Hafta';
  }

  @override
  String get achievementsTitle => 'Başarımlar';

  @override
  String get achievementLocked => 'Henüz kazanılmadı';

  @override
  String get progressTotalCompleted => 'Tamamlanan';

  @override
  String get progressCurrentStreak => 'Güncel seri';

  @override
  String get progressLongestStreak => 'En uzun seri';

  @override
  String get progressCompletion => 'Program ilerlemesi';

  @override
  String get progressWeeklyTitle => 'Haftalık tamamlanma';

  @override
  String get progressActivityTitle => 'Aktivite (son 3 ay)';

  @override
  String progressBadgesSummary(int unlocked, int total) {
    return '$unlocked/$total başarım';
  }

  @override
  String progressWeekDays(int count) {
    return '$count gün';
  }

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsReminders => 'Hatırlatıcılar';

  @override
  String get settingsForceUnlock => 'Tüm haftaların kilidini aç';

  @override
  String get settingsWeeklySummary => 'Haftalık özet bildirimi';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsMorningReminder => 'Sabah Hatırlatıcısı';

  @override
  String get settingsEveningReminder => 'Akşam Hatırlatıcısı';

  @override
  String get settingsWeeklySummaryHint => 'Her Pazar akşamı gönderilir';

  @override
  String get settingsTestNotification => 'Test Bildirimi Gönder';

  @override
  String get settingsTestSent => 'Test bildirimi gönderildi';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsProgramSection => 'Program';

  @override
  String get settingsLevelSystem => 'Seviye sistemi';

  @override
  String get settingsLevelSystemHint =>
      'Haftalar önceki hafta %70 tamamlanınca açılır';

  @override
  String get settingsResetProgress => 'İlerlemeyi Sıfırla';

  @override
  String get settingsResetProgressConfirm =>
      'Tüm tamamlama kayıtların silinecek. Emin misin?';

  @override
  String get settingsDeleteAll => 'Tüm Verileri Sil';

  @override
  String get settingsDeleteAllConfirm1 =>
      'Tüm özel programlar, kayıtlar ve başarımlar silinecek.';

  @override
  String get settingsDeleteAllConfirm2 =>
      'Bu işlem geri alınamaz. Devam edilsin mi?';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get settingsVersion => 'Sürüm';

  @override
  String get settingsHowToUse => 'Nasıl Kullanılır?';

  @override
  String get testNotificationTitle => 'Test 🔔';

  @override
  String get testNotificationBody => 'Bildirimler düzgün çalışıyor!';

  @override
  String get programCreateNew => 'Yeni Program Oluştur';

  @override
  String get programNamePrompt => 'Program adı';

  @override
  String get programResetDefault => 'Varsayılana Sıfırla';

  @override
  String get programResetDefaultConfirm =>
      'Varsayılan program ilk haline döndürülecek. Devam edilsin mi?';

  @override
  String get programActiveChip => 'Etkin';

  @override
  String get programAddWeek => 'Yeni Hafta Ekle';

  @override
  String get programAddExercise => 'Egzersiz Ekle';

  @override
  String get programDeleteExerciseConfirm => 'Bu egzersiz silinsin mi?';

  @override
  String get programDeleteWeekConfirm =>
      'Bu hafta ve tüm egzersizleri silinsin mi?';

  @override
  String get programForceUnlockTitle => 'Haftayı Zorla Aç';

  @override
  String get programForceUnlockExplain =>
      'Bu hafta normalde önceki haftanın %70\'i tamamlanınca açılır. Yine de şimdi açmak istiyor musun?';

  @override
  String get programDayMorning => 'Sabah';

  @override
  String get programDayMidday => 'Öğle';

  @override
  String get programDayEvening => 'Akşam';

  @override
  String get exerciseName => 'Egzersiz adı';

  @override
  String get exerciseType => 'Tür';

  @override
  String get exerciseTypeKegel => 'Kegel';

  @override
  String get exerciseTypeBreath => 'Nefes';

  @override
  String get exerciseTypeMind => 'Zihin';

  @override
  String get exerciseTypeCombo => 'Kombo';

  @override
  String get exerciseSets => 'Set';

  @override
  String get exerciseReps => 'Tekrar';

  @override
  String exerciseHold(int seconds) {
    return 'Tutma süresi: $seconds sn';
  }

  @override
  String exerciseRest(int seconds) {
    return 'Dinlenme: $seconds sn';
  }

  @override
  String get exerciseDescription => 'Açıklama';

  @override
  String get exerciseSteps => 'Adımlar';

  @override
  String get exerciseAddStep => 'Adım Ekle';

  @override
  String exerciseStepHint(int number) {
    return '$number. adım';
  }

  @override
  String get remindersTitle => 'Hatırlatıcılar';

  @override
  String get remindersAddTime => 'Saat Ekle';

  @override
  String get remindersDailyTitle => 'Egzersiz zamanı';

  @override
  String get remindersDailyBody => 'Bugünkü setini tamamlamayı unutma 💪';

  @override
  String get weeklySummaryTitle => 'Haftalık Özet';

  @override
  String weeklySummaryBody(int sessions) {
    return 'Bu hafta $sessions seans tamamladın. Harika gidiyorsun!';
  }

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonCancel => 'Vazgeç';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonEmpty => 'Henüz kayıt yok';

  @override
  String get commonReset => 'Sıfırla';

  @override
  String get commonContinue => 'Devam Et';

  @override
  String get commonClose => 'Kapat';

  @override
  String get errorGeneric => 'Bir şeyler ters gitti';

  @override
  String get errorRetry => 'Tekrar Dene';

  @override
  String get badgeUnlockedTitle => 'Yeni Başarım! 🎉';

  @override
  String badgeUnlockedSnack(String name) {
    return 'Başarım kazanıldı: $name';
  }

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingTitle1 => 'Pelvik Tabanını Güçlendir';

  @override
  String get onboardingBody1 =>
      'Bu 8 haftalık program, pelvik taban kaslarını kademeli olarak güçlendirmen için günlük kısa egzersizler sunar. Düzenli pratikle kontrol ve dayanıklılık kazanırsın.';

  @override
  String get onboardingTitle2 => 'Nasıl Çalışır?';

  @override
  String get onboardingStep1 => 'Her gün sabah ve akşam kısa setleri tamamla.';

  @override
  String get onboardingStep2 =>
      'Rehberli zamanlayıcı kas, tut, bırak ve dinlen fazlarında sana eşlik eder.';

  @override
  String get onboardingStep3 =>
      'Serini sürdür, başarımların kilidini aç ve ilerlemeni izle.';

  @override
  String get onboardingTitle3 => 'Hatırlatıcıları Aç';

  @override
  String get onboardingBody3 =>
      'Egzersizi unutmamak için günlük hatırlatma saatlerini seç. Bunları daha sonra Ayarlar\'dan değiştirebilirsin.';

  @override
  String get onboardingMorning => 'Sabah hatırlatıcısı';

  @override
  String get onboardingEvening => 'Akşam hatırlatıcısı';

  @override
  String get onboardingNext => 'Devam';

  @override
  String get onboardingFinish => 'Başla';
}
