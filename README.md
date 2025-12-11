# 🎬 Flutter Motion Lab

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-4285F4?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**Premium Flutter Animasyonları Sergileme Uygulaması**

*Gerçek dünya uygulamalarından ilham alınmış, prodüksiyon kalitesinde animasyon örnekleri*

</div>

---

## 📖 Proje Hakkında

**Flutter Motion Lab**, Flutter'da yüksek kaliteli animasyonların nasıl oluşturulacağını gösteren bir **showcase (sergileme) uygulamasıdır**. Bu proje, popüler uygulamalardan (Spotify, Duolingo gibi) ilham alınarak hazırlanmış animasyon demolarını içerir.

### 🎯 Projenin Amacı

- Flutter'da **ileri seviye animasyon tekniklerini** öğrenmek ve sergilemek
- **Lottie**, **AnimatedBuilder** ve **özel animasyon controller'ları** kullanımını göstermek
- **Clean Architecture** prensipleriyle organize edilmiş, genişletilebilir kod yapısı sunmak
- Gerçek uygulama senaryolarında animasyonların nasıl kullanıldığını pratik olarak göstermek

---

## ✨ Özellikler

### 🎵 Spotify Now Playing Ekranı
- **Lottie** ile equalizer animasyonu
- **just_audio** paketi ile gerçek ses çalma desteği
- Şarkı ileri/geri sarma, oynat/duraklat kontrolleri
- Dinamik progress bar ve süre göstergesi
- Pulse efektli gradient arka plan
- Eurovision Türkiye şarkıları playlist'i

### 🏆 Duolingo Kutlama Ekranı
- **AnimatedBuilder** ile ölçekleme ve sallanma animasyonu
- **Confetti (konfeti) parçacık animasyonları**
- Glow efektli kartlar
- XP kazanım badge'leri
- Bounce ve elastic easing efektleri

### 🎨 Genel UI/UX Özellikleri
- Modern, koyu tema tasarım
- Material Design 3 uyumlu
- Haptic feedback (dokunsal geri bildirim)
- Smooth sayfa geçiş animasyonları
- Responsive ve modüler widget yapısı

---

## 🛠️ Kullanılan Teknolojiler ve Paketler

| Paket | Versiyon | Kullanım Amacı |
|-------|----------|----------------|
| `flutter` | SDK | Temel framework |
| `lottie` | ^3.1.0 | JSON tabanlı vektör animasyonları (After Effects export) |
| `rive` | ^0.13.0 | İnteraktif animasyonlar için (gelecek demolar için) |
| `just_audio` | ^0.10.5 | Cross-platform ses çalma desteği |
| `cupertino_icons` | ^1.0.6 | iOS tarzı ikonlar |

---

## 📁 Proje Yapısı

```
lib/
├── main.dart                          # Uygulama giriş noktası
├── core/                              # Çekirdek modüller
│   └── theme/
│       └── app_theme.dart             # Uygulama teması ve stil tanımları
└── features/                          # Feature-based mimari
    └── animation_showcase/
        ├── data/
        │   └── demo_animations.dart   # Demo listesi ve metadata
        ├── domain/
        │   └── animation_demo.dart    # AnimationDemo model sınıfı
        └── presentation/
            ├── pages/
            │   ├── home_page.dart                 # Ana sayfa
            │   ├── spotify_now_playing_page.dart  # Spotify demo
            │   └── duolingo_celebration_page.dart # Duolingo demo
            └── widgets/
                └── demo_card.dart     # Demo kartı widget'ı

assets/
├── animations/
│   └── equalizer.json                 # Lottie equalizer animasyonu
└── audio/
    ├── song1.mp3                      # We Could Be the Same - maNga
    ├── song2.mp3                      # Everyway That I Can - Sertab Erener
    └── song3.mp3                      # Düm Tek Tek - Hadise
```

---

## 🚀 Kurulum

### Gereksinimler

- **Flutter SDK**: 3.9.2 veya üzeri
- **Dart SDK**: 3.9 veya üzeri
- **IDE**: VS Code (önerilen) veya Android Studio
- **Desteklenen Platformlar**: Android, iOS, Web, Windows, macOS, Linux

### Adım Adım Kurulum

#### 1. Projeyi Klonlayın

```bash
git clone https://github.com/dusova/flutter-motion-lab.git
cd flutter-motion-lab
```

#### 2. Bağımlılıkları Yükleyin

```bash
flutter pub get
```

#### 3. Flutter Ortamınızı Kontrol Edin

```bash
flutter doctor
```

Tüm kontrollerin ✓ işareti ile geçtiğinden emin olun.

---

## ▶️ Çalıştırma

### Android Emulator veya Fiziksel Cihazda

```bash
# Debug modda çalıştır
flutter run

# Release modda çalıştır (performans testi için)
flutter run --release
```

### iOS Simulator'da (macOS gerektirir)

```bash
flutter run -d ios
```

### Web Tarayıcısında

```bash
flutter run -d chrome
```

### Windows Desktop

```bash
flutter run -d windows
```

### macOS Desktop

```bash
flutter run -d macos
```

### Linux Desktop

```bash
flutter run -d linux
```

### Belirli Bir Cihazda Çalıştırma

```bash
# Mevcut cihazları listele
flutter devices

# Belirli bir cihazda çalıştır
flutter run -d <device_id>
```

---

## 📱 Uygulama Kullanımı

1. **Ana Sayfa**: Uygulama açıldığında mevcut animasyon demolarını listeleyen ana sayfa görüntülenir
2. **Demo Seçimi**: Herhangi bir demo kartına tıklayarak ilgili animasyon sayfasına geçiş yapın
3. **Spotify Demo**: Şarkıları çalın, duraklatın ve playlist'te gezinin
4. **Duolingo Demo**: Kutlama animasyonunu izleyin ve "Tekrar" butonuyla yeniden oynatın
5. **Geri Dönüş**: Sayfa üzerindeki geri tuşu veya aşağı ok ile ana sayfaya dönün

---

## 🏗️ Build & Release

### Android APK Oluşturma

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# APK Split (boyut optimizasyonu)
flutter build apk --split-per-abi
```

APK dosyası: `build/app/outputs/flutter-apk/` klasöründe oluşturulur.

### Android App Bundle (Play Store için)

```bash
flutter build appbundle --release
```

### iOS Build (macOS gerektirir)

```bash
flutter build ios --release
```

### Web Build

```bash
flutter build web --release
```

Build çıktısı: `build/web/` klasöründe oluşturulur.

### Windows Build

```bash
flutter build windows --release
```

---

## 🧪 Test

```bash
# Tüm testleri çalıştır
flutter test

# Coverage ile test çalıştır
flutter test --coverage
```

---

## 📚 Öğrenme Kaynakları

Bu projede kullanılan animasyon tekniklerini öğrenmek için:

### AnimatedBuilder
- Özel animasyon controller'ları oluşturma
- Tween ve CurvedAnimation kullanımı
- `vsync` ve `TickerProviderStateMixin`

### Lottie
- After Effects'ten export edilen JSON animasyonları
- AnimationController ile senkronizasyon
- Performans optimizasyonu

### Audio Entegrasyonu
- `just_audio` ile cross-platform ses çalma
- Stream listener'lar ile durum yönetimi
- Playlist ve şarkı geçişleri

---

## 🤝 Katkıda Bulunma

1. Bu repository'yi fork edin
2. Feature branch oluşturun (`git checkout -b feature/YeniAnimasyon`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni animasyon eklendi'`)
4. Branch'inizi push edin (`git push origin feature/YeniAnimasyon`)
5. Pull Request açın

---

## 📋 Gelecek Planlar

- [ ] Rive animasyon demoları eklenmesi
- [ ] Hero animasyonları örneği
- [ ] Custom painter ile çizim animasyonları
- [ ] Implicit animations koleksiyonu
- [ ] Physics-based animasyonlar
- [ ] Staggered animasyonlar

---

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakınız.

---

## 👨‍💻 Geliştirici

**Flutter Motion Lab** - Premium Flutter Animasyonları

---

<div align="center">

⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!

**Made with ❤️ and Flutter**

</div>
