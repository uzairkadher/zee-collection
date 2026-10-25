// Basic structure for product reading. Auth required for writes.
export async function onRequestGet(context) {
    const { env } = context;

    // Safety check: ensure DB is bound
    if (!env.DB) {
        return new Response(JSON.stringify({ error: { code: "SERVER_ERROR", message: "Database binding missing." } }), { status: 500 });
    }

    try {
        // Fetch only published products
        const { results } = await env.DB.prepare(`
            SELECT id, title, description, base_price_pkr, is_featured
            FROM products
            WHERE is_published = 1
            ORDER BY created_at DESC
        `).all();

        return new Response(JSON.stringify({ data: results }), {
            headers: {
                "Content-Type": "application/json",
            }
        });
    } catch (e) {
        return new Response(JSON.stringify({ error: { code: "DB_ERROR", message: "Failed to fetch products." } }), { status: 500 });
    }
}
