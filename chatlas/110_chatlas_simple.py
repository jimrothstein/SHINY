from chatlas import ChatOpenRouter

chat = ChatOpenRouter(
    model="particle-ai/particle-1:free",  # free tier model on OpenRouter (gemma free pool was rate-limited)
    system_prompt="You are a helpful assistant.",
)

# Optional tool registration
def get_current_weather(lat: float, lng: float):
    "Get the current weather for a given location."
    return "sunny"

chat.register_tool(get_current_weather)

# Send user prompt to the model for a response.
chat.chat("What is the capital of France?")
chat.chat("How's the weather in San Francisco?")

chat.chat("Teach me two things about 'chatlas' ")
