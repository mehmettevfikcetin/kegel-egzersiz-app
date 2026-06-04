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
  String get homeStartSession => 'Antrenmana Başla';

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
  String get sessionPause => 'Duraklat';

  @override
  String get sessionResume => 'Devam Et';

  @override
  String get sessionFinish => 'Bitir';

  @override
  String get sessionAbort => 'İptal';

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
}
