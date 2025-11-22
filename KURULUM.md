# 🏥 Hospital Appointment System - Kurulum Rehberi

## ✅ Proje Durumu

Tam kapsamlı bir Hospital Appointment Management System oluşturuldu:
- ✅ Rails 8 API Backend
- ✅ React Frontend  
- ✅ Cypress E2E Testleri
- ✅ Video Narration Pipeline

## ⚠️ PostgreSQL Yapılandırması Gerekli

PostgreSQL 18 kurulu ancak şifre yapılandırması gerekiyor.

### Seçenek 1: pgAdmin ile Şifre Ayarlama (ÖNERİLEN)

1. **pgAdmin 4'ü açın** (Başlat menüsünden)
2. **PostgreSQL 18** sunucusuna bağlanın
3. **Login/Group Roles** → **postgres** üzerine sağ tıklayın
4. **Properties** → **Definition** sekmesine gidin
5. **Password** alanına `1234` yazın
6. **Save** butonuna tıklayın

### Seçenek 2: Komut Satırı ile

```powershell
# PostgreSQL servisinin çalıştığından emin olun
# Sonra şu komutu çalıştırın:
& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -c "ALTER USER postgres PASSWORD '1234';"
```

### Seçenek 3: Trust Authentication (Geçici)

Eğer yukarıdaki yöntemler çalışmazsa:

1. `C:\Program Files\PostgreSQL\18\data\pg_hba.conf` dosyasını bulun
2. Dosyayı yönetici olarak açın
3. En üste şu satırları ekleyin:
```
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
```
4. PostgreSQL servisini yeniden başlatın
5. Şifreyi ayarlamak için:
```powershell
& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -h 127.0.0.1 -c "ALTER USER postgres PASSWORD '1234';"
```
6. pg_hba.conf'daki "trust"ları "md5" ile değiştirin
7. Servisi tekrar yeniden başlatın

## 🚀 Kurulum Adımları

### 1. PostgreSQL Şifresini Ayarlayın
Yukarıdaki yöntemlerden birini kullanarak postgres kullanıcısının şifresini `1234` olarak ayarlayın.

### 2. Backend Kurulumu
```powershell
cd hospital_appointment_api
bundle install
rails db:create db:migrate db:seed
rails s
```

Backend `http://localhost:3000` adresinde çalışacak.

### 3. Frontend Kurulumu (Yeni Terminal)
```powershell
cd hospital-appointment-frontend
npm install
npm run dev
```

Frontend `http://localhost:5173` adresinde çalışacak.

### 4. Demo Video Oluşturma
```powershell
cd hospital-appointment-frontend

# Cypress testi çalıştır
npx cypress run --spec "cypress/e2e/demo.feature"

# Ses dosyası oluştur
pip install -r requirements.txt
python generate_audio.py

# Final videoyu oluştur
./render_video.ps1
```

## 📧 Test Kullanıcı Bilgileri

`rails db:seed` çalıştırıldıktan sonra:
- **Email**: `patient@example.com`
- **Şifre**: `password123`

## 🔧 Sorun Giderme

### "password authentication failed" Hatası
- PostgreSQL şifresinin `1234` olarak ayarlandığından emin olun
- `config/database.yml` dosyasında şifrenin doğru olduğunu kontrol edin
- PostgreSQL servisinin çalıştığından emin olun

### PostgreSQL Servisi Çalışmıyor
1. **Hizmetler** (Services) uygulamasını açın
2. "postgresql" araması yapın
3. Servisi başlatın

### Port Kullanımda
- Backend (3000): Diğer Rails sunucularını kapatın
- Frontend (5173): Diğer Vite sunucularını kapatın

## 📁 Proje Yapısı

```
hospital_appointment_api/          # Rails 8 API
├── app/controllers/api/v1/        # API Controllers
├── app/models/                    # Domain Models
├── spec/                          # RSpec Tests
└── features/                      # Cucumber Features

hospital-appointment-frontend/     # React Frontend
├── src/pages/                     # UI Pages
├── cypress/                       # E2E Tests
├── hospital_demo.srt              # Narration Script
├── generate_audio.py              # TTS Generator
└── render_video.ps1               # Video Renderer
```

## 🎯 API Endpoints

- `POST /api/v1/auth/register` - Yeni hasta kaydı
- `POST /api/v1/auth/login` - Giriş
- `GET /api/v1/auth/me` - Mevcut kullanıcı
- `GET /api/v1/departments` - Departmanlar
- `GET /api/v1/doctors` - Doktorlar
- `GET /api/v1/appointments` - Randevular
- `POST /api/v1/appointments` - Randevu oluştur

## 🎬 Demo Video Özellikleri

- ✅ Görsel imleç vurgulama
- ✅ Adım adım anlatım
- ✅ Giriş akışı gösterimi
- ✅ Randevu rezervasyon akışı
- ✅ Profesyonel seslendirme

---

**Not**: PostgreSQL şifresi ayarlandıktan sonra tüm komutlar sorunsuz çalışacaktır!
