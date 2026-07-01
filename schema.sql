CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  salt TEXT NOT NULL,
  iterations INTEGER NOT NULL,
  created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS documents (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL,
  number TEXT NOT NULL,
  business TEXT NOT NULL,
  customer_name TEXT,
  email TEXT,
  phone TEXT,
  status TEXT NOT NULL DEFAULT 'Draft',
  paid INTEGER NOT NULL DEFAULT 0,
  token TEXT NOT NULL,
  total REAL NOT NULL DEFAULT 0,
  data_json TEXT NOT NULL,
  approved_by TEXT,
  approved_at TEXT,
  approval_notes TEXT,
  paid_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_documents_updated_at ON documents(updated_at);
CREATE INDEX IF NOT EXISTS idx_documents_token ON documents(token);

CREATE TABLE IF NOT EXISTS item_manager_items (
  id TEXT PRIMARY KEY,
  sku TEXT NOT NULL UNIQUE,
  item_name TEXT NOT NULL,
  size TEXT,
  pack TEXT,
  price REAL NOT NULL DEFAULT 0,
  quantity REAL NOT NULL DEFAULT 0,
  instore_qty REAL NOT NULL DEFAULT 0,
  cost REAL NOT NULL DEFAULT 0,
  msrp REAL NOT NULL DEFAULT 0,
  tax1 INTEGER NOT NULL DEFAULT 1,
  tax2 INTEGER NOT NULL DEFAULT 0,
  tax3 INTEGER NOT NULL DEFAULT 0,
  reorder_level REAL NOT NULL DEFAULT 0,
  department TEXT,
  category TEXT,
  sub_category TEXT,
  brand TEXT,
  supplier TEXT,
  item_group TEXT,
  item_type TEXT NOT NULL DEFAULT 'Standard',
  location TEXT,
  upc TEXT,
  vendor_sku TEXT,
  notes TEXT,
  image_url TEXT,
  public_description TEXT,
  published INTEGER NOT NULL DEFAULT 1,
  active INTEGER NOT NULL DEFAULT 1,
  child_item INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_name ON item_manager_items(item_name);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_dept_cat ON item_manager_items(department, category);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_active ON item_manager_items(active);


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
