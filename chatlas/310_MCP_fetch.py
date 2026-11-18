# 310_MCP_fetch

import asyncio
import chatlas as ctl 
from chatlas import ChatOpenRouter

# chat object

async def main():
    chat = ChatOpenRouter(
      model="particle-ai/particle-1:free",  # free tier model on OpenRouter (gemma free pool was rate-limited)
      system_prompt="You are a helpful assistant.",
    )
    await chat.register_mcp_tools_stdio_async(
        command="uvx",
        args=["mcp-server-fetch"],
    )
    resp = await chat.chat_async(
        "Summarize the first paragraph of https://en.wikipedia.org/wiki/Python_(programming_language)"
    )
    print(resp.content)
    await chat.cleanup_mcp_tools()

asyncio.run(main())
