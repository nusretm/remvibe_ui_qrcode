# RemVibe UI QR — Çalışma ve Mimari Kuralları

Bu belge `remvibe_ui_qrcode` repository'sinin authoritative çalışma standardıdır.
Kaynak: `nusretm/mtn_launcher` projesinin `docs/WORKING_RULES.md` belgesindeki
genel mühendislik kuralları; yalnız QR widget paketine uygulanabilir kurallar
uyarlanmıştır. Minecraft, loader, installer, provider helper ve FFI kuralları
bu projede geçerli değildir.

## 1. Onay ve çalışma düzeni

- Önce mevcut repository, kaynak kod, bağımlılıklar ve continuity incelenir.
- Kullanıcı açıkça onay vermeden **yeni bir implementation checkpoint'i** başlatılmaz.
- Onaylanan iş kapsamı dışına sessizce çıkılmaz.
- Büyük iş küçük, gözden geçirilebilir checkpoint'lere ayrılır; tek bir adımda
  gereksiz mimari veya çok sayıda özellik üretilmez.
- Değişiklikler feature branch üzerinde yapılır; kullanıcı onayı olmadan merge yapılmaz.
- İlk commit bulunmayan boş repository'yi başlatmak için gereken teknik bootstrap
  durumu continuity'de açıkça belirtilir.
- Gereksiz patch dosyası, büyük prompt ve test altyapısı kurulmaz.

## 2. Mimari sınır

Public paket yalnız iki widget sunar:

- `RemVibeUIQRCode`: `String` verisini ekranda QR olarak gösterir.
- `RemVibeUIQRScanner`: Android/iOS kamerasından QR okur ve düz `String` bildirir.

Paket; AvukatPro, Customer Server, kullanıcı hesabı, login, token,
QR eşleştirme protokolü veya navigasyon akışını bilmez.
QR payload'u parse edilmez, yorumlanmaz, kaydedilmez veya loglanmaz.
Sunucu bağlantısı kurulmaz. Başka RemVibe paketine bağımlı olunmaz.

`pretty_qr_code` yalnız QR gösterimi, `mobile_scanner` yalnız kamera
taraması için kullanılır. Bu üçüncü taraf paketlere ait ayrıntılar
widget implementasyonları içinde saklanır.

**Yasak gereksiz katmanlar:** `QRService`, `AccountService`, singleton manager,
provider, registry, event bus, genel amaçlı controller veya ilerisi için
soyutlama. Var olan iki widget yeterliyse yeni sınıf eklenmez.

## 3. API ve isimlendirme

- Public API olabildiğince küçük ve anlaşılır tutulur.
- Her parametrenin açık anlamı ve varsayılan davranışı olmalıdır.
- Sınıf ailesi gerekli hale gelirse genel standart: abstract sınıflara `Abs`,
  concrete reusable base sınıflara `Base` son eki; specialization aile
  öneki korunarak sona eklenir. Ancak bu proje için yeni inheritance
  hiyerarşisi oluşturulmaz.
- `StatefulWidget` için Flutter'ın doğal `State<...>` yapısı kullanılır.
- Kapsayıcı sınıflar ve çok sayıda private helper ile basit işler karmaşıklaştırılmaz.
- İlk release öncesinde kullanıcı açıkça istemedikçe legacy compatibility,
  deprecated wrapper veya migration katmanı oluşturulmaz.

## 4. Platform kapsamı

| Platform | QR gösterimi | Kamera taraması |
| --- | --- | --- |
| Windows | Hedef | Destek dışı görünüm |
| Linux | Hedef | Destek dışı görünüm |
| macOS | Hedef | Destek dışı görünüm |
| Android | Kullanılabilir | Hedef |
| iOS | Kullanılabilir | Hedef |
| Web | Kapsam dışı | Kapsam dışı |

Web'e özel kod, test ve destek vaadi yoktur. `mobile_scanner` üst paketi
macOS/Web desteklese dahi bu paket ilk sürümde oralarda tarama sunmaz.
Desktop'ta tarama için kamera hiç başlatılmaz; kullanıcıya kontrollü durum gösterilir.

## 5. Widget kaynak ve hata yönetimi

- QR gösteriminde yeterli kontrast ve quiet zone korunur; veri değiştiğinde
  widget yenilenir. Boş veya kapasiteyi aşan veriler deterministik hata
  görünümüne dönüşür.
- Scanner kamerasını yalnız widget'ın lifecycle'ı yönetir.
- Desteklenen platformda kamera görünümü kendi widget alanındadır.
- Kamera izni reddi, kamera açılamaması ve desteklenmeyen platform durumları
  kontrollü biçimde gösterilir; uygulamanın navigasyonu yönetilmez.
- Scanner **one-shot** çalışır: ilk dolu QR metni için senkron kilit alınır,
  asenkron `FutureOr<void> Function(String)` callback yalnız bir kez çağrılır.
  İşlem sürerken tekrar bildirim yapılmaz; callback tamamlandığında otomatik
  ikinci okuma yapılmaz. Yeni tarama için yeni scanner widget oturumu gerekir.
- Widget dispose veya uygulama lifecycle değişiminde kamera/kaynak temizliği
  güvenli, tekrarlanabilir ve yarış koşullarına dayanıklı olmalıdır.
- Callback hatası yeniden deneme veya ikinci callback üretmez. Ham payload
  ve hassas hata ayrıntıları otomatik loglanmaz.
- İzin isteme ve kamera erişimi OS'nin izin mekanizmasını kullanır; gizli
  bir izin atlatma akışı kurulmaz.

## 6. Doğrulama öncelikleri

- Önce çalışan widget ve gerçek cihaz/masaüstü deneyimi.
- Windows üzerinde gerçek QR gösterimi ve Android üzerinde gerçek kamera
  ile QR okuma ilk live validation hedefleridir.
- Gereken kadar odaklı test; ardından `flutter test` ve `dart analyze` /
  `flutter analyze` uygun bağlamda çalıştırılır.
- Pure Dart dosyalarında kullanıcı açıkça istemedikçe `dart format`
  çalıştırılmaz. Formatlama için ek bağımsız checkpoint açılmaz.
- Analyze veya test geçmesi gerçek cihaz çalışmasının kanıtı değildir.
- Değişen kaynaklar ve gerçek diff bağımsız incelenir; sorumluluk, lifecycle,
  hatalar, ek bağımlılıklar ve doküman doğruluğu denetlenir.
- Çalıştırılmayan komutlar veya denenmeyen cihazlar `PASS` yazılmaz.

## 7. Dependency, dosya ve repository disiplini

- Flutter'ın standart `lib/`, `example/`, `test/`, `docs/` yapısı kullanılır.
- Bağımlılıklar ilk hedefte `pretty_qr_code: 3.6.0` ve
  `mobile_scanner: 7.4.2` ile sınırlandırılır; yeni production
  bağımlılığı için kullanıcı onayı alınır.
- Gerçek `flutter --version`, `flutter pub get`, native platform build
  uyumluluğu uygulanırken doğrulanır.
- `.gitignore` Flutter/Dart/IDE generated dosyaları ayırır; kaynak,
  manifest, Gradle wrapper ve gerekli lockfile gibi gerçek proje
  dosyaları yanlışlıkla ignore edilmez.
- README platform entegrasyonu için kopyalanabilir `pubspec.yaml`,
  widget kullanım kodu, Android/iOS izin ve minimum SDK açıklamaları
  ve Example çalıştırma komutları içermelidir.
- README'deki kurulum adımları sürümle birlikte gözden geçirilir;
  henüz doğrulanmamış bilgiler açıkça işaretlenir.

## 8. Continuity ve checkpoint kapanışı

`docs/continuity/` her çalışma öncesinde okunur. Minimum belgeler:
`README.md`, `CURRENT_TARGET.md`, `ARCHITECTURE.md`.

Her önemli tasarım, uygulama, hata ve live validation sonrası kaydedilir:
hedef, kapsam, gözlenen kanıt, kullanılan cihaz/komut, sonuç, çözülemeyen
risk ve sonraki adım. `DESIGNED`, `IMPLEMENTED`, `TESTED`,
`LIVE_VERIFIED`, `BLOCKED`, `DEFERRED` durumları ayrı tutulur.
Sohbet geçmişi continuity yerine geçmez. Önceki doğrulanmış davranış
kanıtsız yere yeniden yazılmaz.

## 9. Teslim/merge

Checkpoint bitince gerçek değişen dosyalar, analiz/test/cihaz sonuçları,
kalan sorunlar ve branch/commit bilgisi özetlenir.
**Merge yalnız kullanıcı açık onay verdiğinde** yapılır.
