# Takım Defteri

Doğu ve Güneydoğu Anadolu bölgesine özel düğün takı defteri uygulaması. Düğün kültüründeki takı takma, geri dönüş defteri tutma ve düğün takvimi yönetimi ihtiyaçlarını karşılar.

## Özellikler

- **Hızlı Takı Girişi**: Yaşlı dostu, büyük dokunma alanlı UI ile offline çalışan takı kayıt ekranı
- **Geri Dönüş Defteri**: Misafir takip ve karşılıklılık kontrolü
- **Düğün Takvimi**: Aylık takvim görünümü, çakışma uyarıları ve sezon analizi
- **Offline-First**: İnternet olmadan çalışır, bağlantı gelince otomatik senkronize eder
- **Yerel Esnaf Reklamları**: Native reklam banner'ları ile kuyumcu, düğün salonu gibi yerel işletme tanıtımları

## Teknoloji Stack

| Katman | Teknoloji |
|--------|-----------|
| Frontend | Flutter 3.22+ |
| State Mgmt | Riverpod |
| Backend | Supabase (Auth + PostgreSQL + RT) |
| Local DB | Drift (SQLite) |
| DI | get_it |
| Navigation | go_router |
| Charts | fl_chart |

## Mimari

Clean Architecture + Offline-First yaklaşımı kullanılmaktadır:

```
lib/
├── core/           # Constants, errors, network, theme, utils
├── data/           # Local (Drift) + Remote (Supabase) + Repositories
├── domain/         # Entities, repository interfaces, use cases
└── presentation/   # Screens, providers, common widgets
```

## Kurulum

### Gereksinimler
- Flutter SDK >= 3.22
- Dart SDK >= 3.0
- Supabase projesi

### Adımlar

1. **Bağımlılıkları yükle**:
```bash
flutter pub get
```

2. **Kod üretimini çalıştır** (Drift tabloları için):
```bash
dart run build_runner build --delete-conflicting-outputs
```

3. **Supabase yapılandır**:
   - `supabase/schema.sql` dosyasını Supabase SQL editöründe çalıştır
   - Supabase URL ve Anon Key'i ortam değişkenlerine ekle:
```bash
flutter run --dart-define=SUPABASE_URL=https://your-project.supabase.co \
            --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

4. **Uygulamayı başlat**:
```bash
flutter run
```

## Veritabanı Şeması

Supabase SQL şeması `supabase/schema.sql` dosyasında bulunur. RLS politikaları ve performans indeksleri dahildir.

## Gelir Modeli

Uygulama tamamen ücretsizdir. Gelir yalnızca yerel esnaf native reklamlarından sağlanır:
- Kuyumcular
- Düğün salonları
- Catering firmaları
- Fotoğrafçılar
- Çiçekçiler

## Lisans

Bu proje özel kullanım içindir.
