-- ZEE COLLECTION: Initial D1 Database Schema

-- Administrators Table (Fixed to 3 admins as per requirements)
CREATE TABLE administrators (
    id TEXT PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sessions Table for Authentication
CREATE TABLE sessions (
    id TEXT PRIMARY KEY,
    admin_id TEXT NOT NULL,
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(admin_id) REFERENCES administrators(id) ON DELETE CASCADE
);

-- Products Table
CREATE TABLE products (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    base_price_pkr INTEGER NOT NULL, -- Stored as integer to avoid floating point issues
    is_published BOOLEAN DEFAULT 0,
    is_featured BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Product Images Table
CREATE TABLE product_images (
    id TEXT PRIMARY KEY,
    product_id TEXT NOT NULL,
    r2_object_key TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Variants Table (e.g. Size, Color)
CREATE TABLE variants (
    id TEXT PRIMARY KEY,
    product_id TEXT NOT NULL,
    sku TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL, -- e.g., "Silver/Black", "42mm"
    price_override_pkr INTEGER, -- Null means use base_price_pkr
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Inventory Table (Atomic operations required)
CREATE TABLE inventory (
    variant_id TEXT PRIMARY KEY,
    quantity_available INTEGER NOT NULL DEFAULT 0,
    quantity_reserved INTEGER NOT NULL DEFAULT 0,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(variant_id) REFERENCES variants(id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE orders (
    id TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    customer_email TEXT NOT NULL,
    customer_phone TEXT NOT NULL,
    delivery_address TEXT NOT NULL,
    delivery_city TEXT NOT NULL,
    total_pkr INTEGER NOT NULL,
    delivery_fee_pkr INTEGER NOT NULL,
    -- State Machines:
    status_order TEXT NOT NULL DEFAULT 'PENDING_REVIEW', -- PENDING_REVIEW, CONFIRMED, CANCELLATION_REQUESTED, CANCELLED
    status_payment TEXT NOT NULL DEFAULT 'PENDING', -- PENDING, AWAITING_VERIFICATION, PAID, FAILED, REFUND_PENDING, PARTIALLY_REFUNDED, REFUNDED
    status_fulfillment TEXT NOT NULL DEFAULT 'NOT_STARTED', -- NOT_STARTED, PROCESSING, PACKED, DISPATCHED
    status_shipping TEXT NOT NULL DEFAULT 'AWAITING_SHIPMENT', -- AWAITING_SHIPMENT, SHIPPED, IN_TRANSIT, DELIVERED, DELIVERY_ISSUE
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Order Items Table
CREATE TABLE order_items (
    id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    variant_id TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price_at_purchase_pkr INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE RESTRICT,
    FOREIGN KEY(variant_id) REFERENCES variants(id) ON DELETE RESTRICT
);

-- Inventory Reservations (For cart expiry logic)
CREATE TABLE inventory_reservations (
    id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    variant_id TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(variant_id) REFERENCES variants(id) ON DELETE CASCADE
);

-- Private Payment Evidence
CREATE TABLE payment_evidence (
    id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    r2_object_key TEXT NOT NULL UNIQUE,
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    verified_by_admin_id TEXT,
    verification_status TEXT DEFAULT 'PENDING', -- PENDING, APPROVED, REJECTED
    verification_notes TEXT,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(verified_by_admin_id) REFERENCES administrators(id)
);

-- Settings Table (Key/Value store for operations)
CREATE TABLE store_settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_by TEXT NOT NULL
);

-- Audit Logs Table
CREATE TABLE audit_logs (
    id TEXT PRIMARY KEY,
    admin_id TEXT,
    action TEXT NOT NULL,
    entity_type TEXT NOT NULL, -- e.g., 'ORDER', 'PRODUCT', 'SETTING'
    entity_id TEXT,
    details TEXT, -- JSON payload of before/after or specific actions
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(admin_id) REFERENCES administrators(id) ON DELETE SET NULL
);
