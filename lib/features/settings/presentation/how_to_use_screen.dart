import 'package:flutter/material.dart';

import '../../../core/localization/gen/app_localizations.dart';

/// Native, scrollable "Nasıl Kullanılır?" guide explaining the 8-week program,
/// daily sets, the level/unlock rule, reminders and progress tracking.
class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  static const _sections = <(IconData, String, String)>[
    (
      Icons.flag_outlined,
      'Programın Amacı',
      'Bu uygulama, pelvik taban farkındalığını, nefes kontrolünü ve uyarılma '
          'yönetimini 8 hafta boyunca 4 fazda kademeli olarak geliştirmen için '
          'tasarlandı. Her hafta bir öncekinin üzerine inşa edilir.',
    ),
    (
      Icons.wb_sunny_outlined,
      'Günlük Setler',
      'Her gün için sabah, öğle ve akşam setleri bulunur. Ana Sayfa’dan o günün '
          'setini başlat. Egzersiz ekranındaki zamanlayıcı kas, tut, bırak ve '
          'dinlen aşamalarında sana eşlik eder.',
    ),
    (
      Icons.lock_open_outlined,
      'Seviye Sistemi',
      'Haftalar kilitli başlar. Bir haftanın egzersizlerinin en az %70’ini '
          'tamamladığında bir sonraki hafta otomatik açılır. İstersen Ayarlar’dan '
          'seviye sistemini kapatabilir ya da bir haftayı “Zorla Aç” ile '
          'erkenden açabilirsin.',
    ),
    (
      Icons.tune,
      'Programı Düzenleme',
      'Program ekranındaki düzenleme bölümünden kendi programını oluşturabilir, '
          'egzersiz ekleyip çıkarabilir, set/tekrar ve sürelerini değiştirebilir '
          've egzersizleri sürükleyerek yeniden sıralayabilirsin.',
    ),
    (
      Icons.notifications_active_outlined,
      'Hatırlatıcılar',
      'Ayarlar’dan sabah ve akşam hatırlatıcılarını aç, saatlerini seç. Pazar '
          'akşamı haftalık özet bildirimi ile ilerlemeni gözden geçir.',
    ),
    (
      Icons.insights_outlined,
      'İlerleme ve Başarımlar',
      'İlerleme ve Geçmiş ekranlarından serini, tamamladığın seansları ve '
          'aktivite takvimini takip et. Hedeflere ulaştıkça başarımların açılır.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsHowToUse)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final (icon, title, body) in _sections)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(body,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
