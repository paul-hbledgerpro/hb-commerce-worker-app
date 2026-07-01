
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
  active INTEGER NOT NULL DEFAULT 1,
  child_item INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_name ON item_manager_items(item_name);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_dept_cat ON item_manager_items(department, category);
CREATE INDEX IF NOT EXISTS idx_item_manager_items_active ON item_manager_items(active);
