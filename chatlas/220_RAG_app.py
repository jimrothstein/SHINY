import raghilda as rag

from rag import get_top_k_similar_documents
from shiny.express import ui
from chatlas import ChatOpenRouter

# chat object
chat = ChatOpenRouter(
    model="particle-ai/particle-1:free",  # free tier model on OpenRouter (gemma free pool was rate-limited)
    system_prompt="""
    You are a helpful AI assistant. Using the provided context,
    answer the user's question. If you cannot answer the question based on the
    context, say so."
   """,
)



chat = ui.Chat(
    id="chat",
    messages=["Hello! How can I help you today?"],
)
chat.ui()

chat.update_user_input(value="Who created the unicorn language?")

@chat.on_user_submit
async def _(user_input: str):
    top_docs = get_top_k_similar_documents(user_input, top_k=3)
    prompt = f"Context: {top_docs}\nQuestion: {user_input}"
    response = await chat_client.stream_async(prompt)
    await chat.append_message_stream(response)