# Smartstore Railway Deployment Guide

Bu rehber, Smartstore'u Railway'de external PostgreSQL servisi ile nasıl deploy edeceğinizi açıklar.

## Gereksinimler

- Railway hesabı
- Mevcut PostgreSQL servisi (Railway'de veya external)
- Git repository'si

## Railway'de Deploy Etme

### 1. Railway'de Yeni Proje Oluşturma

1. [Railway.app](https://railway.app) adresine gidin
2. "New Project" butonuna tıklayın
3. "Deploy from GitHub repo" seçin
4. Bu repository'yi seçin

### 2. Environment Variables Ayarlama

Railway dashboard'da "Variables" sekmesine gidin ve şu environment variables'ları ekleyin:

```bash
# PostgreSQL Connection (Railway PostgreSQL servisi için)
DATABASE_URL=postgresql://username:password@host:port/database

# Alternatif olarak ayrı ayrı:
ConnectionStrings__DefaultConnection=Host=host;Port=port;Database=database;Username=username;Password=password;

# ASP.NET Core ayarları
ASPNETCORE_ENVIRONMENT=Production
ASPNETCORE_URLS=http://0.0.0.0:$PORT

# Smartstore ayarları (opsiyonel)
Smartstore__MediaStoragePath=/app/App_Data/Tenants
Smartstore__UseDbCache=true
Smartstore__UsePooledDbContextFactory=true
```

### 3. Build Ayarları

Railway otomatik olarak `Dockerfile.railway` dosyasını kullanacaktır. Eğer manuel ayar yapmak isterseniz:

1. "Settings" sekmesine gidin
2. "Build" bölümünde:
   - Builder: Dockerfile
   - Dockerfile Path: `Dockerfile.railway`

### 4. Deploy

1. "Deploy" butonuna tıklayın
2. Railway otomatik olarak build işlemini başlatacak
3. Build tamamlandıktan sonra uygulama çalışmaya başlayacak

## Dosya Açıklamaları

### Dockerfile.railway
- Railway için optimize edilmiş Dockerfile
- PostgreSQL container'ı içermez
- External PostgreSQL kullanır
- Railway'in PORT environment variable'ını kullanır

### docker-compose.railway.yml
- Local test için kullanılabilir
- Sadece web servisi içerir
- External PostgreSQL'e bağlanır

### appsettings.railway.json
- Production için optimize edilmiş ayarlar
- Razor runtime compilation kapalı
- Bundling ve minification açık
- Security ayarları güçlendirilmiş

### railway.json
- Railway platform konfigürasyonu
- Build ve deploy ayarları
- Restart policy tanımları

## Troubleshooting

### Database Connection Hatası
- `DATABASE_URL` environment variable'ının doğru olduğundan emin olun
- PostgreSQL servisinin çalıştığından emin olun
- Firewall ayarlarını kontrol edin

### Build Hatası
- Dockerfile.railway dosyasının doğru olduğundan emin olun
- Build loglarını kontrol edin
- .NET 9 SDK gereksinimini kontrol edin

### Memory Hatası
- Railway'de daha yüksek memory planı seçin
- `Smartstore__DbContextPoolSize` değerini düşürün

## Performance Optimizasyonu

1. **Database Connection Pooling**: `UsePooledDbContextFactory=true`
2. **Caching**: `UseDbCache=true`
3. **Bundling**: Production'da açık
4. **Minification**: CSS/JS dosyaları için açık

## Monitoring

Railway dashboard'da şu metrikleri takip edin:
- CPU kullanımı
- Memory kullanımı
- Network trafiği
- Response time

## Backup

PostgreSQL veritabanınızı düzenli olarak backup almayı unutmayın. Railway'de otomatik backup özelliği mevcuttur.
