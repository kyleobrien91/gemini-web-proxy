import os
import uvicorn

if __name__ == "__main__":
    port = int(os.getenv("GEMINI_PROXY_PORT", 8080))
    uvicorn.run(
        "server:app",
        host="0.0.0.0",
        port=port,
        log_level="info"
    )
