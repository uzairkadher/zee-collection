# Testing Strategy and Procedures

## Environment
*   **Primary Development/Testing:** Android device using SPCK Editor.
*   **Staging:** Cloudflare Pages preview deployments (required for testing Pages Functions).

## SPCK Editor Testing Procedure
Because SPCK Editor on Android serves static files locally, you can test the frontend UI (HTML/CSS/JS) without backend integration:
1.  Open the project folder in SPCK Editor.
2.  Open `index.html`.
3.  Use the built-in live preview to view the site on your mobile screen.
4.  Verify that layout conforms to mobile widths (no horizontal scrolling).
5.  To test offline state, toggle your device's airplane mode and observe the UI changes.

*Note: API calls, database queries, and file uploads cannot be tested locally in SPCK. They require a Cloudflare deployment.*

## Acceptance Criteria Checklist (Phase 1)
- [ ] Mobile layout works at 320px+ width without horizontal overflow.
- [ ] Visual identity uses black, white, and gold.
- [ ] Offline state is clearly indicated.
- [ ] No fake data or deceptive UI elements are present.
