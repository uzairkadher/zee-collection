# Implementation Checklist: ZEE COLLECTION

Based on the inspection of the current repository and the phase 2 execution requirements.

## 1. Database (Cloudflare D1)
- [ ] Create `schema.sql`.
- [ ] Define `administrators` table (3 fixed admins).
- [ ] Define `sessions` table (secure authentication).
- [ ] Define `products` and `product_images` tables.
- [ ] Define `variants` and `inventory` (including reservations).
- [ ] Define `orders`, `order_items`.
- [ ] Define `payment_records` and `private_evidence_metadata`.
- [ ] Define `cancellation_requests` and `refunds`.
- [ ] Define `store_settings`.
- [ ] Define `audit_logs`.

## 2. Backend API (Cloudflare Pages Functions)
- [ ] Set up `functions/api/` routing structure.
- [ ] Implement `functions/api/auth/` (login, logout, session verification, bcrypt hashing).
- [ ] Implement `functions/api/products/` (CRUD for admin, GET for storefront).
- [ ] Implement `functions/api/inventory/` (atomic stock reservations, expiry).
- [ ] Implement `functions/api/cart/` (server-side price validation).
- [ ] Implement `functions/api/orders/` (checkout, order state machine).
- [ ] Implement `functions/api/payments/` (verification, evidence metadata).
- [ ] Implement `functions/api/upload/` (R2 presigned URLs, auth checks, file validation).

## 3. Storage (Cloudflare R2)
- [ ] Ensure public access pattern for `product-images`.
- [ ] Ensure private, authenticated-only access pattern for `payment-evidence`.

## 4. Admin Panel (Frontend UI)
- [ ] Create `/admin/index.html` (Login page).
- [ ] Create `/admin/dashboard.html` (Stats, alerts).
- [ ] Create `/admin/products.html` (Manage catalog, upload images).
- [ ] Create `/admin/orders.html` (View, filter, manage state transitions).
- [ ] Create `/admin/payments.html` (Verify evidence, approve refunds).
- [ ] Create `/admin/settings.html` (Manage operational settings).
- [ ] Create `js/admin.js` for API integration and CSRF handling.

## 5. Storefront Updates (Frontend UI)
- [ ] Implement dynamic product fetching in `js/app.js`.
- [ ] Build product detail views (modals or separate pages).
- [ ] Implement cart UI and local storage sync.
- [ ] Implement checkout form (guest checkout, address, payment method).
- [ ] Implement order confirmation view.

## 6. Security & Documentation
- [ ] Create `.env.example` with placeholder secrets.
- [ ] Add deployment & configuration instructions to `README.md`.
- [ ] Update `TESTING.md` with backend/staging test procedures.
