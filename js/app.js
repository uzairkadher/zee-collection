/**
 * ZEE COLLECTION - Phase 1 Application Logic
 * Implements offline detection and basic UI state management.
 * Does NOT contain fake data or checkout logic as per project constraints.
 */

document.addEventListener('DOMContentLoaded', () => {
    // UI Elements
    const offlineBanner = document.getElementById('offline-banner');
    const currentYearSpan = document.getElementById('current-year');
    const productGrid = document.getElementById('product-grid');
    const errorState = document.getElementById('error-state');
    const emptyState = document.getElementById('empty-state');
    const retryBtn = document.getElementById('retry-btn');

    // Initialize Footer Year
    if (currentYearSpan) {
        currentYearSpan.textContent = new Date().getFullYear();
    }

    // Network State Management
    function updateNetworkStatus() {
        if (navigator.onLine) {
            offlineBanner.classList.add('hidden');
        } else {
            offlineBanner.classList.remove('hidden');
        }
    }

    window.addEventListener('online', updateNetworkStatus);
    window.addEventListener('offline', updateNetworkStatus);
    updateNetworkStatus(); // Initial check

    // UI State Management Functions
    // Exposed globally to allow the (future) API layer to control the view
    window.AppUI = {
        showLoading: () => {
            productGrid.innerHTML = '<div class="loading-state"><p>Loading catalogue...</p></div>';
            productGrid.classList.remove('hidden');
            errorState.classList.add('hidden');
            emptyState.classList.add('hidden');
        },
        showError: () => {
            productGrid.classList.add('hidden');
            errorState.classList.remove('hidden');
            emptyState.classList.add('hidden');
        },
        showEmpty: () => {
            productGrid.classList.add('hidden');
            errorState.classList.add('hidden');
            emptyState.classList.remove('hidden');
        },
        renderProducts: (htmlString) => {
            productGrid.innerHTML = htmlString;
            productGrid.classList.remove('hidden');
            errorState.classList.add('hidden');
            emptyState.classList.add('hidden');
        }
    };

    // Retry Button Logic
    if (retryBtn) {
        retryBtn.addEventListener('click', () => {
            window.AppUI.showLoading();
            // Note: In Phase 2, this will trigger the real API fetch.
            // For Phase 1, it just returns to the loading state to demonstrate UI transitions.
            console.log("Retry clicked. API call omitted in Phase 1.");
        });
    }
});
