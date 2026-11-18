import numpy as np

# from HF
from sentence_transformers import SentenceTransformer

embed_model = SentenceTransformer("sentence-transformers/all-MiniLM-L12-v2")

# A list of 'documents' (one document per list element)
documents = [
    "The unicorn programming language was created by Horsey McHorseface.",
    "It's known for its magical syntax and rainbow-colored variables.",
    "Unicorn is a dynamically typed language with a focus on readability.",
    "Some other programming languages include Python, Java, and C++.",
    "Some other useless context...",
]

# Compute embeddings for each document (do this once for performance reasons)
embeddings = [embed_model.encode([doc])[0] for doc in documents]

def get_top_k_similar_documents(user_query, top_k=3):
    # Compute embedding for the user query
    query_embedding = embed_model.encode([user_query])[0]

    # Calculate cosine similarity between the query and each document
    similarities = np.dot(embeddings, query_embedding) / (
        np.linalg.norm(embeddings, axis=1) * np.linalg.norm(query_embedding)
    )

    # Get the top-k most similar documents
    top_indices = np.argsort(similarities)[-top_k:][::-1]
    return [documents[i] for i in top_indices]
