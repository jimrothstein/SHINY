# 120_chatlas_stream.py
# REF: https://posit-dev.github.io/chatlas/get-started/stream.html

from chatlas import ChatOpenRouter

# chat object
chat = ChatOpenRouter(
    model="particle-ai/particle-1:free",  # free tier model on OpenRouter (gemma free pool was rate-limited)
    system_prompt="You are a helpful assistant.",
)

# Optional tool registration
def get_current_weather(lat: float, lng: float):
    "Get the current weather for a given location."
    return "sunny"

chat.register_tool(get_current_weather)

stream = chat.stream("My name is Chatlas.", content="all")
for chunk in stream:
    print(chunk)

len(chat.get_turns())  # 2

