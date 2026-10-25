export async function onRequest(context) {
    // Health check endpoint. No DB query, just confirms routing works.
    return new Response(JSON.stringify({
        status: "ok",
        message: "ZEE COLLECTION API is running."
    }), {
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
        }
    });
}
