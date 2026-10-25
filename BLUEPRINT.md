# ZEE COLLECTION Architecture Blueprint

## Executive Summary
ZEE COLLECTION (zeecollection.tech) is a premium e-commerce storefront. The initial launch catalog is strictly **watches**. The market is Pakistan, using PKR currency.

## Architecture
1.  **Frontend:** Static HTML, CSS, Vanilla JS. Served via Cloudflare Pages.
2.  **Backend/API:** Cloudflare Pages Functions. Handles authorization, input validation, and D1/R2 interactions.
3.  **Database (D1):** Authoritative source for structured records (products, orders, stock, audit logs).
4.  **Storage (R2):** Stores product images (public) and payment evidence (strictly private).

## Key Design Principles
*   **Mobile-First:** Designed and tested for narrow Android viewport widths (320px+).
*   **Visual Identity:** Premium, minimalist, black, white, and gold.
*   **Honesty & Transparency:** No fake reviews, fake stock counters, or deceptive UI patterns. Clear error and offline states.
*   **Security:** Three independent admin accounts. All manual payment verification and refund management requires strict authorization.

## Unresolved Owner Decisions (Pending)
*   Exact seller legal identity and dispatch origin.
*   Sales area (Pakistan-wide vs. specific cities).
*   Finalized payment methods and courier providers.
*   Return/warranty policy.
