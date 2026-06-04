# Kegel Egzersiz Takip

**TR** — 8 haftalık, yapılandırılmış bir pelvik taban antrenman uygulaması. Kegel egzersizleri, nefes teknikleri ve zihinsel odak çalışmalarını rehberli oturumlar halinde sunar; ilerlemeni takip eder, seriler ve rozetlerle motive eder.

**EN** — A structured, 8-week pelvic floor training app. It delivers Kegel exercises, breathing techniques and mindfulness drills as guided sessions, tracks your progress, and keeps you motivated with streaks and badges.

---

## Özellikler / Features

- 🗓️ **8 haftalık program / 8-week program** — Aşamalı 4 fazlı plan (Temel, Geliştirme, Entegrasyon, Otomasyon). / Progressive 4-phase plan (Foundation, Development, Integration, Automation).
- ⏱️ **Rehberli egzersiz oturumları / Guided exercise sessions** — Sıkma, tutma, bırakma ve dinlenme fazları için zamanlayıcı, titreşim ve sesli ipuçları. / Timer with vibration and audio cues for squeeze, hold, release and rest phases.
- 🫁 **Nefes & zihin egzersizleri / Breathing & mindfulness** — Kegel'in yanında nefes ve odaklanma çalışmaları. / Breathing and focus drills alongside Kegel work.
- 📊 **İlerleme takibi / Progress tracking** — Grafikler, takvim görünümü ve tamamlama geçmişi. / Charts, calendar view and completion history.
- 🔥 **Seriler & rozetler / Streaks & badges** — Günlük seriler ve kilit açılabilen başarımlar. / Daily streaks and unlockable achievements.
- 🔔 **Hatırlatıcılar / Reminders** — Yerel bildirimlerle günlük egzersiz hatırlatmaları. / Daily exercise reminders via local notifications.
- ✏️ **Özelleştirilebilir program / Customizable program** — Egzersizleri ve setleri düzenle. / Edit exercises and sets.
- 🌙 **Açık/koyu tema / Light & dark theme** — Sistem temasına uyum. / Follows the system theme.
- 📴 **Çevrimdışı & gizli / Offline & private** — Tüm veriler cihazda (SQLite), hesap gerekmez. / All data stays on-device (SQLite), no account required.

## Ekran Görüntüleri / Screenshots

Ekran görüntüleri eklenecek. / Screenshots will be added.

## Teknolojiler / Tech Stack

- **Flutter, Dart**
- **Drift (SQLite)** — yerel veritabanı / local database
- **Riverpod 3.x** — durum yönetimi / state management
- **go_router** — yönlendirme / navigation
- **fl_chart** — grafikler / charts
- **flutter_local_notifications** — hatırlatıcılar / reminders
- **table_calendar** — takvim görünümü / calendar view
- Ayrıca / Also: `timezone`, `permission_handler`, `vibration`, `audioplayers`, `confetti`, `shared_preferences`, `intl`

## Kurulum / Getting Started

> Gereksinim / Requirement: Flutter SDK (3.11+ Dart, kanal: stable).

```bash
# 1. Bağımlılıkları yükle / Install dependencies
flutter pub get

# 2. Kod üretimini çalıştır (Drift) / Run code generation (Drift)
dart run build_runner build --delete-conflicting-outputs

# 3. Uygulamayı çalıştır / Run the app
flutter run
```

Sürüm APK'sı oluşturmak için / To build a release APK:

```bash
flutter build apk --release
# Çıktı / Output: build/app/outputs/flutter-apk/app-release.apk
```

## Proje Yapısı / Project Structure

Özellik-öncelikli (feature-first) bir klasör yapısı kullanılır. / The project uses a feature-first folder structure.

```
lib/
├── app.dart                  # Kök widget, tema & yönlendirme / Root widget, theme & routing
├── main.dart                 # Giriş noktası / Entry point
├── core/                     # Paylaşılan altyapı / Shared infrastructure
│   ├── database/             # Drift tabloları, DAO'lar, seed / Drift tables, DAOs, seed
│   ├── localization/         # ARB & üretilen çeviriler / ARB & generated translations
│   ├── notifications/        # Yerel bildirim servisi / Local notification service
│   ├── router/               # go_router yapılandırması / go_router config
│   ├── theme/                # Renkler, palet, tema / Colors, palette, theme
│   ├── providers/ services/ utils/ widgets/
├── data/                     # Repository'ler & sağlayıcılar / Repositories & providers
└── features/                 # Ekran bazlı özellikler / Screen-based features
    ├── home/                 # Ana sayfa / Home
    ├── program/              # Program görünümü / Program view
    ├── program_editor/       # Program düzenleyici / Program editor
    ├── exercise_session/     # Egzersiz oturumu & zamanlayıcı / Exercise session & timer
    ├── progress/             # İlerleme grafikleri / Progress charts
    ├── history/              # Geçmiş & oturum detayı / History & session detail
    ├── achievements/         # Rozetler / Badges
    ├── onboarding/           # İlk kurulum / Onboarding
    └── settings/             # Ayarlar / Settings
```

## Lisans / License

[MIT](LICENSE) © 2026 Mehmet Tevfik Çetin
