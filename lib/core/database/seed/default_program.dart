/// Pure data describing the built-in 8-week program (4 phases × 2 weeks).
/// No I/O here — [SeedRunner] turns these into Drift rows on first launch.
/// Bumping content here + `SeedRunner.currentSeedVersion` ships new defaults
/// without touching user-created programs or logs.
library;

import '../tables/exercises.dart' show DayPart, ExerciseType;

/// One exercise in the seed. The four phase durations (seconds) + `reps`/`sets`
/// describe the timer. For `breath`, squeeze = inhale and release = exhale;
/// for `mind`/`combo` the whole guided block is encoded as a single long `hold`
/// (in seconds) over `reps` cycles, with the real instructions in [steps].
class SeedExercise {
  final String name;
  final DayPart dayPart;
  final ExerciseType type;
  final String? description;
  final List<String>? steps;
  final int squeeze;
  final int hold;
  final int release;
  final int rest;
  final int reps;
  final int sets;
  const SeedExercise({
    required this.name,
    this.dayPart = DayPart.morning,
    this.type = ExerciseType.kegel,
    this.description,
    this.steps,
    required this.squeeze,
    required this.hold,
    required this.release,
    required this.rest,
    required this.reps,
    this.sets = 1,
  });
}

class SeedWeek {
  final int weekIndex;
  final int phase;
  final String title;
  final String phaseName;
  final double unlockThreshold;
  final List<SeedExercise> exercises;
  const SeedWeek({
    required this.weekIndex,
    required this.phase,
    required this.title,
    required this.phaseName,
    this.unlockThreshold = 0.70,
    required this.exercises,
  });
}

class SeedProgram {
  final String name;
  final String description;
  final List<SeedWeek> weeks;
  const SeedProgram({
    required this.name,
    required this.description,
    required this.weeks,
  });
}

const defaultProgram = SeedProgram(
  name: '8 Haftalık Pelvik Kontrol Programı',
  description:
      'Pelvik taban farkındalığını, nefes kontrolünü ve uyarılma yönetimini '
      '4 fazda kademeli olarak geliştiren 8 haftalık başlangıç programı.',
  weeks: [
    // ===== FAZ 1 — TEMEL (1-2. hafta) =====
    SeedWeek(
      weekIndex: 1,
      phase: 1,
      phaseName: 'Temel',
      title: 'Kası Bul, Nefesi Öğren',
      exercises: [
        SeedExercise(
          name: 'Temel Kegel',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description:
              'Pelvik taban kasını bul ve 3 saniye tut. Nefesini tutma, '
              'normal nefes almaya devam et.',
          steps: [
            'Rahat bir pozisyonda otur veya uzan.',
            'İdrarını tutar gibi pelvik taban kasını sık.',
            '3 saniye boyunca kasılı tut.',
            'Yavaşça gevşet ve 3 saniye dinlen.',
            'Karın, kalça ve bacaklarını gevşek tut.',
          ],
          squeeze: 2, hold: 3, release: 2, rest: 3, reps: 10, sets: 2,
        ),
        SeedExercise(
          name: '4-2-6 Nefes Tekniği',
          dayPart: DayPart.evening,
          type: ExerciseType.breath,
          description:
              '4 saniye burnundan nefes al, 2 saniye tut, 6 saniye ağzından '
              'ver. Yaklaşık 5 dakika.',
          steps: [
            'Sırt üstü uzan veya dik otur.',
            '4 saniye boyunca burnundan derin nefes al.',
            'Nefesini 2 saniye tut.',
            '6 saniye boyunca ağzından yavaşça ver.',
            '10 tur tekrarla.',
          ],
          squeeze: 4, hold: 2, release: 6, rest: 0, reps: 10,
        ),
      ],
    ),
    SeedWeek(
      weekIndex: 2,
      phase: 1,
      phaseName: 'Temel',
      title: 'Süreyi Artır',
      exercises: [
        SeedExercise(
          name: 'Uzun Kegel',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description: 'Tutma süresini 5 saniyeye çıkar, dinlenmeyi de uzat.',
          steps: [
            'Pelvik taban kasını sık.',
            '5 saniye boyunca kasılı tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            'Nefesini düzenli tutmaya özen göster.',
          ],
          squeeze: 2, hold: 5, release: 2, rest: 5, reps: 10, sets: 2,
        ),
        SeedExercise(
          name: '4-2-6 Nefes + Günlük Entegrasyon',
          dayPart: DayPart.evening,
          type: ExerciseType.breath,
          description:
              'Nefes tekniğini gün içindeki sıradan anlara taşı '
              '(kuyrukta, trafikte, masada).',
          steps: [
            '4-2-6 nefesini 10 tur uygula.',
            'Gün içinde en az 3 farklı anı seç.',
            'O anlarda 3 tur 4-2-6 nefesi al.',
            'Bedenindeki gevşemeyi fark et.',
          ],
          squeeze: 4, hold: 2, release: 6, rest: 0, reps: 10,
        ),
      ],
    ),

    // ===== FAZ 2 — GELİŞİM (3-4. hafta) =====
    SeedWeek(
      weekIndex: 3,
      phase: 2,
      phaseName: 'Gelişim',
      title: 'Uyarılma Ölçeğini Öğren',
      exercises: [
        SeedExercise(
          name: 'Kegel Tekrar Artışı',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description: 'Tekrar sayısını 12’ye çıkar, 5 saniye tutmaya devam et.',
          steps: [
            'Pelvik taban kasını sık ve 5 saniye tut.',
            'Yavaşça gevşet ve 4 saniye dinlen.',
            '12 tekrar, 2 set yap.',
          ],
          squeeze: 2, hold: 5, release: 2, rest: 4, reps: 12, sets: 2,
        ),
        SeedExercise(
          name: 'Uyarılma Ölçeği Pratiği',
          dayPart: DayPart.evening,
          type: ExerciseType.mind,
          description:
              'Uyarılmayı 0–10 ölçeğinde fark etmeyi öğren. Yaklaşık 10 '
              'dakikalık farkındalık çalışması.',
          steps: [
            'Sakin bir yere uzan.',
            'Bedenindeki duyumları gözlemle.',
            'Uyarılma düzeyini 0–10 arası bir sayıyla etiketle.',
            'Yargılamadan yalnızca fark et.',
            '10 dakika boyunca gözleme devam et.',
          ],
          squeeze: 0, hold: 600, release: 0, rest: 0, reps: 1,
        ),
      ],
    ),
    SeedWeek(
      weekIndex: 4,
      phase: 2,
      phaseName: 'Gelişim',
      title: '7’de Dur',
      exercises: [
        SeedExercise(
          name: 'Kegel Süre Artışı',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description: 'Tutma süresini 7 saniyeye çıkar.',
          steps: [
            'Pelvik taban kasını sık ve 7 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '12 tekrar, 2 set yap.',
          ],
          squeeze: 2, hold: 7, release: 2, rest: 5, reps: 12, sets: 2,
        ),
        SeedExercise(
          name: 'Dur-Başla + Nefes',
          dayPart: DayPart.evening,
          type: ExerciseType.combo,
          description:
              'Uyarılma 7’ye ulaştığında dur, 4-2-6 nefesiyle 5–6’ya indir, '
              'sonra devam et. 3 döngü, ~15 dakika.',
          steps: [
            'Uyarılmanı 6–7 düzeyine getir.',
            'Tam orada dur.',
            '4-2-6 nefesini uygula.',
            'Uyarılma 5’e inene kadar bekle.',
            'Yeniden başla ve döngüyü 3 kez tekrarla.',
          ],
          squeeze: 0, hold: 240, release: 0, rest: 30, reps: 3,
        ),
      ],
    ),

    // ===== FAZ 3 — ENTEGRASYON (5-6. hafta) =====
    SeedWeek(
      weekIndex: 5,
      phase: 3,
      phaseName: 'Entegrasyon',
      title: 'Nefes + Kegel Birlikte',
      exercises: [
        SeedExercise(
          name: 'Senkronize Kegel + Nefes',
          dayPart: DayPart.morning,
          type: ExerciseType.combo,
          description:
              'Nefes verirken kasıl, nefes alırken gevşe. Kegel ve nefesi '
              'senkronize et.',
          steps: [
            '4 saniye burnundan nefes al, kasları gevşek tut.',
            'Nefesini kısa bir an tut.',
            '6 saniye verirken pelvik tabanı 7 saniyeye kadar sık.',
            'Yavaşça gevşet.',
            '10 tekrar, 2 set yap.',
          ],
          squeeze: 4, hold: 7, release: 6, rest: 4, reps: 10, sets: 2,
        ),
        SeedExercise(
          name: 'Tam Kombinasyon Pratiği',
          dayPart: DayPart.evening,
          type: ExerciseType.combo,
          description:
              'Kegel, nefes ve uyarılma kontrolünü tek seansta birleştir. '
              '4 döngü, ~20 dakika.',
          steps: [
            'Uyarılmanı 6–7 düzeyine çıkar.',
            'Senkronize kegel + nefesle 5’e indir.',
            'Kısa bir dinlenme ver.',
            'Döngüyü toplam 4 kez tekrarla.',
          ],
          squeeze: 0, hold: 270, release: 0, rest: 30, reps: 4,
        ),
      ],
    ),
    SeedWeek(
      weekIndex: 6,
      phase: 3,
      phaseName: 'Entegrasyon',
      title: 'Kontrollü Dalgalanma',
      exercises: [
        SeedExercise(
          name: 'Yatarak Kegel',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description: 'Sırt üstü uzanarak 8 saniye tutmalı kegel.',
          steps: [
            'Sırt üstü uzan, dizlerini hafifçe bük.',
            'Pelvik taban kasını sık ve 8 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 8, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Otururken Kegel',
          dayPart: DayPart.midday,
          type: ExerciseType.kegel,
          description: 'Dik otururken aynı 8 saniyelik tutmayı uygula.',
          steps: [
            'Sandalyede dik otur, ayakların yere bassın.',
            'Pelvik taban kasını sık ve 8 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 8, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Ayakta Kegel',
          dayPart: DayPart.evening,
          type: ExerciseType.kegel,
          description: 'Ayakta dururken 8 saniyelik tutmayı uygula.',
          steps: [
            'Ayakta dik dur, ağırlığını iki ayağına eşit ver.',
            'Pelvik taban kasını sık ve 8 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 8, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Dalgalanma Pratiği',
          dayPart: DayPart.evening,
          type: ExerciseType.combo,
          description:
              'Uyarılmayı bilinçli olarak 4 ↔ 7 arasında dalgalandır. '
              '5 döngü, ~25 dakikalık seans.',
          steps: [
            'Uyarılmanı 4 düzeyine getir.',
            'Yavaşça 7’ye çıkar, orada dur.',
            'Kegel + nefesle tekrar 4’e indir.',
            'Döngüyü toplam 5 kez tekrarla.',
          ],
          squeeze: 0, hold: 240, release: 0, rest: 30, reps: 5,
        ),
      ],
    ),

    // ===== FAZ 4 — OTOMASYON (7-8. hafta) =====
    SeedWeek(
      weekIndex: 7,
      phase: 4,
      phaseName: 'Otomasyon',
      title: 'Durmadan Kontrol',
      exercises: [
        SeedExercise(
          name: 'Üç Pozisyon Kegel — Yatarak',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description: 'Yatarak 10 saniye tutmalı kegel.',
          steps: [
            'Sırt üstü uzan.',
            'Pelvik taban kasını sık ve 10 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 10, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Üç Pozisyon Kegel — Otururken',
          dayPart: DayPart.midday,
          type: ExerciseType.kegel,
          description: 'Otururken 10 saniye tutmalı kegel.',
          steps: [
            'Dik otur.',
            'Pelvik taban kasını sık ve 10 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 10, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Üç Pozisyon Kegel — Ayakta',
          dayPart: DayPart.evening,
          type: ExerciseType.kegel,
          description: 'Ayakta 10 saniye tutmalı kegel.',
          steps: [
            'Ayakta dik dur.',
            'Pelvik taban kasını sık ve 10 saniye tut.',
            'Yavaşça gevşet ve 5 saniye dinlen.',
            '10 tekrar yap.',
          ],
          squeeze: 2, hold: 10, release: 2, rest: 5, reps: 10,
        ),
        SeedExercise(
          name: 'Hareket Halinde Müdahale',
          dayPart: DayPart.evening,
          type: ExerciseType.combo,
          description:
              'Yürürken veya hareket halindeyken uyarılma yükseldiğinde '
              'durmadan kasıl ve nefesle kontrol et. ~20 dakika.',
          steps: [
            'Yavaş tempoda yürümeye başla.',
            'Uyarılma yükseldiğinde durmadan pelvik tabanı sık.',
            'Aynı anda 4-2-6 nefesini uygula.',
            'Uyarılmayı yürümeyi kesmeden dengele.',
          ],
          squeeze: 0, hold: 1200, release: 0, rest: 0, reps: 1,
        ),
      ],
    ),
    SeedWeek(
      weekIndex: 8,
      phase: 4,
      phaseName: 'Otomasyon',
      title: 'Pekiştirme',
      exercises: [
        SeedExercise(
          name: 'Koruma Kegeli',
          dayPart: DayPart.morning,
          type: ExerciseType.kegel,
          description:
              'Kazanımları korumak için 10 saniyelik tutmalı bakım kegeli.',
          steps: [
            'Pelvik taban kasını sık ve 10 saniye tut.',
            'Yavaşça gevşet ve 4 saniye dinlen.',
            '10 tekrar, 2 set yap.',
          ],
          squeeze: 2, hold: 10, release: 2, rest: 4, reps: 10, sets: 2,
        ),
        SeedExercise(
          name: 'Program Sonu Değerlendirme + Tam Kombinasyon',
          dayPart: DayPart.evening,
          type: ExerciseType.combo,
          description:
              'Tüm becerileri birleştir: kegel, nefes ve uyarılma kontrolü. '
              'Programın başındaki halinle şimdiki halini karşılaştır.',
          steps: [
            'Senkronize kegel + nefesle ısın.',
            'Uyarılmayı 4 ↔ 7 arasında kontrollü dalgalandır.',
            '7’de dur-başla tekniğini uygula.',
            'İlk haftalara göre gelişimini değerlendir ve not al.',
          ],
          squeeze: 0, hold: 900, release: 0, rest: 0, reps: 1,
        ),
      ],
    ),
  ],
);

class SeedBadge {
  final String code;
  final String title;
  final String description;
  final String iconName;
  const SeedBadge(this.code, this.title, this.description, this.iconName);
}

/// The full badge catalogue. `code` is the stable identifier the
/// [BadgeService] checks against; titles/descriptions may be re-seeded on a
/// version bump without resetting unlock state.
const seedBadges = <SeedBadge>[
  SeedBadge('first_session', 'İlk Adım', 'İlk egzersizini tamamladın.', 'flag'),
  SeedBadge('streak_7', 'Bir Hafta', 'Üst üste 7 gün egzersiz yaptın.',
      'whatshot'),
  SeedBadge('streak_30', 'Bir Ay', 'Üst üste 30 gün egzersiz yaptın.',
      'calendar_month'),
  SeedBadge('phase_1_complete', 'Temel Ustası', 'Faz 1’i baştan sona bitirdin.',
      'looks_one'),
  SeedBadge('phase_2_complete', 'Geliştirme Ustası',
      'Faz 2’yi baştan sona bitirdin.', 'looks_two'),
  SeedBadge('phase_3_complete', 'Entegrasyon Ustası',
      'Faz 3’ü baştan sona bitirdin.', 'looks_3'),
  SeedBadge('phase_4_complete', 'Otomasyon Ustası',
      'Faz 4’ü baştan sona bitirdin.', 'looks_4'),
  SeedBadge('program_complete', 'Tam Kontrol', '8 haftalık programı tamamladın.',
      'emoji_events'),
  SeedBadge('custom_program', 'Kendi Programın', 'İlk özel programını oluşturdun.',
      'edit'),
  SeedBadge('hundred_sessions', 'Yüzler Kulübü',
      'Toplam 100 egzersiz tamamladın.', 'military_tech'),
];
