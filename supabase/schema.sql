-- ================================================
-- TAKIM DEFTERİ - Supabase Veritabanı Şeması
-- Doğu ve Güneydoğu Anadolu düğün kültürüne özel
-- takı defteri uygulaması için veritabanı şeması
-- ================================================

-- Kullanıcı profilleri (Supabase Auth ile bağlantılı)
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  phone TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  city TEXT,
  district TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Düğünler
CREATE TABLE weddings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  bride_name TEXT NOT NULL,
  groom_name TEXT NOT NULL,
  wedding_date DATE NOT NULL,
  venue TEXT,
  city TEXT,
  notes TEXT,
  is_my_wedding BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Misafirler
CREATE TABLE wedding_guests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  phone TEXT,
  city TEXT,
  relationship TEXT,  -- 'family', 'neighbor', 'coworker', 'friend'
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Takı türleri (sabit referans tablosu)
CREATE TABLE gift_types (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,          -- 'Bilezik', 'Çeyrek Altın', 'Yarım Altın', 'Tam Altın', 'Cumhuriyet', 'TL Nakit', 'Döviz', 'Diğer'
  category TEXT NOT NULL,      -- 'gold', 'cash', 'foreign_currency', 'other'
  unit TEXT NOT NULL,          -- 'adet', 'gram', 'TL'
  is_active BOOLEAN DEFAULT TRUE
);

-- Sabit takı türleri verisi
INSERT INTO gift_types (name, category, unit) VALUES
  ('Bilezik', 'gold', 'adet'),
  ('Çeyrek Altın', 'gold', 'adet'),
  ('Yarım Altın', 'gold', 'adet'),
  ('Tam Altın', 'gold', 'adet'),
  ('Cumhuriyet', 'gold', 'adet'),
  ('TL Nakit', 'cash', 'TL'),
  ('Döviz', 'foreign_currency', 'adet'),
  ('Diğer', 'other', 'adet');

-- Günlük döviz ve altın kurları
CREATE TABLE exchange_rates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  rate_date DATE NOT NULL UNIQUE,
  usd_try DECIMAL(10,4),
  eur_try DECIMAL(10,4),
  gold_gram_try DECIMAL(10,4),  -- Gram altın TL karşılığı
  quarter_gold_try DECIMAL(10,4),
  half_gold_try DECIMAL(10,4),
  full_gold_try DECIMAL(10,4),
  republic_gold_try DECIMAL(10,4),
  source TEXT DEFAULT 'manual',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Mock exchange rate data
INSERT INTO exchange_rates (rate_date, usd_try, eur_try, gold_gram_try, quarter_gold_try, half_gold_try, full_gold_try, republic_gold_try, source)
VALUES
  (CURRENT_DATE, 32.50, 35.20, 2450.00, 4200.00, 8400.00, 16800.00, 17500.00, 'mock');

-- Takılar (hediyeler) - Enflasyon korumalı yapı
CREATE TABLE gifts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  local_id TEXT UNIQUE NOT NULL,       -- Drift'teki yerel ID (sync için)
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  wedding_id UUID NOT NULL REFERENCES weddings(id) ON DELETE CASCADE,
  guest_id UUID REFERENCES wedding_guests(id) ON DELETE SET NULL,
  guest_name_snapshot TEXT NOT NULL,   -- Misafir silinse bile isim korunur
  gift_type_id INTEGER REFERENCES gift_types(id),
  quantity DECIMAL(10,3) NOT NULL DEFAULT 1,
  recorded_amount_try DECIMAL(12,2),   -- Takıldığı andaki TL değeri
  exchange_rate_id UUID REFERENCES exchange_rates(id),
  notes TEXT,
  given_at TIMESTAMPTZ NOT NULL,       -- Takının takıldığı zaman
  is_synced BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Reklam verenler (yerel esnaf)
CREATE TABLE advertisers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  business_name TEXT NOT NULL,
  category TEXT NOT NULL,    -- 'jewelry', 'wedding_hall', 'catering', 'photography', 'florist'
  city TEXT NOT NULL,
  district TEXT,
  phone TEXT,
  address TEXT,
  logo_url TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Reklam kampanyaları
CREATE TABLE ad_campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  advertiser_id UUID NOT NULL REFERENCES advertisers(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  coupon_code TEXT,
  discount_text TEXT,       -- '% 15 indirim', '500 TL hediye çeki'
  target_cities TEXT[],     -- ['Diyarbakır', 'Şanlıurfa']
  placement TEXT NOT NULL,  -- 'home_banner', 'list_inline', 'gift_entry_bottom'
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  click_count INTEGER DEFAULT 0,
  impression_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Senkronizasyon kuyruğu (Offline-First için)
CREATE TABLE sync_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  table_name TEXT NOT NULL,
  operation TEXT NOT NULL,   -- 'INSERT', 'UPDATE', 'DELETE'
  local_id TEXT NOT NULL,
  payload JSONB NOT NULL,
  retry_count INTEGER DEFAULT 0,
  last_error TEXT,
  is_processed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================
-- RLS Politikaları
-- ================================================
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE weddings ENABLE ROW LEVEL SECURITY;
ALTER TABLE wedding_guests ENABLE ROW LEVEL SECURITY;
ALTER TABLE gifts ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_queue ENABLE ROW LEVEL SECURITY;

-- Users: sadece kendi profilini görebilir
CREATE POLICY "Kullanici kendi profilini gorur" ON users FOR ALL USING (auth.uid() = id);

-- Weddings: sadece kendi düğünlerini görebilir
CREATE POLICY "Kullanici kendi dugunlerini gorur" ON weddings FOR ALL USING (auth.uid() = user_id);

-- Gifts: sadece kendi takılarını görebilir
CREATE POLICY "Kullanici kendi takilarini gorur" ON gifts FOR ALL USING (auth.uid() = user_id);

-- Wedding Guests: sadece kendi misafirlerini görebilir
CREATE POLICY "Kullanici kendi misafirlerini gorur" ON wedding_guests FOR ALL USING (auth.uid() = user_id);

-- Sync Queue: sadece kendi senkronizasyon kuyruğunu görebilir
CREATE POLICY "Kullanici kendi senkronunu gorur" ON sync_queue FOR ALL USING (auth.uid() = user_id);

-- Gift types ve exchange_rates herkese açık (referans tabloları)
-- Advertisers ve ad_campaigns herkese açık (reklam içeriği)

-- ================================================
-- RPC Fonksiyonları (Reklam sayaçları için)
-- ================================================

CREATE OR REPLACE FUNCTION increment_impression(campaign_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE ad_campaigns
  SET impression_count = impression_count + 1
  WHERE id = campaign_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION increment_click(campaign_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE ad_campaigns
  SET click_count = click_count + 1
  WHERE id = campaign_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ================================================
-- İndeksler (Performans optimizasyonu)
-- ================================================
CREATE INDEX idx_weddings_user_id ON weddings(user_id);
CREATE INDEX idx_weddings_date ON weddings(wedding_date);
CREATE INDEX idx_gifts_wedding_id ON gifts(wedding_id);
CREATE INDEX idx_gifts_user_id ON gifts(user_id);
CREATE INDEX idx_gifts_guest_id ON gifts(guest_id);
CREATE INDEX idx_wedding_guests_user_id ON wedding_guests(user_id);
CREATE INDEX idx_ad_campaigns_placement ON ad_campaigns(placement);
CREATE INDEX idx_ad_campaigns_active ON ad_campaigns(is_active, start_date, end_date);
CREATE INDEX idx_sync_queue_user ON sync_queue(user_id, is_processed);
