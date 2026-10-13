# Continuity index

Bu dizin, RemVibe UI QR için authoritative devamlılık kayıtlarıdır.
Yeni sohbet, Codex oturumu veya development checkpoint öncesinde sırasıyla:

1. [WORKING_RULES.md](../WORKING_RULES.md)
2. [CURRENT_TARGET.md](CURRENT_TARGET.md)
3. [ARCHITECTURE.md](ARCHITECTURE.md)

okunmalıdır.

- `CURRENT_TARGET.md`: aktif checkpoint, tamamlanan iş, doğrulama ve sıradaki hedef.
- `ARCHITECTURE.md`: platform matrisi, public API, hata/lifecycle contracts.
- Yalnız gerçekten gerekli olursa yeni belge eklenir; tek widget için
  gereksiz ayrı plan/test dosyaları oluşturulmaz.

Durumlar: `DESIGNED` (karar alındı), `IMPLEMENTED` (kod var),
`TESTED` (test komutu çalıştı), `LIVE_VERIFIED` (gerçek cihaz/desktop
kanıtı var), `BLOCKED`, `DEFERRED`. Bu terimler birbirinin yerine kullanılmaz.
Belgeye commit/branch, platform, kullanılan komut, gerçek sonuç ve açık risk ekle.

Son güncelleme: 2026-10-13.
