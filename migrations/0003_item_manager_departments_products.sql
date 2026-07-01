
ALTER TABLE item_manager_items ADD COLUMN image_url TEXT;
ALTER TABLE item_manager_items ADD COLUMN public_description TEXT;
ALTER TABLE item_manager_items ADD COLUMN published INTEGER NOT NULL DEFAULT 1;

CREATE TABLE IF NOT EXISTS item_manager_departments (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  image_url TEXT,
  link_url TEXT,
  display_order INTEGER NOT NULL DEFAULT 100,
  active INTEGER NOT NULL DEFAULT 1,
  system_department INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_item_manager_departments_slug ON item_manager_departments(slug);
