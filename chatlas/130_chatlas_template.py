# 130_chatlas_template.py

# Purpose:  We have template.md (or it will be created here).  Note use of {{}}

import chatlas as ctl 
from chatlas import ChatOpenRouter

# chat object
chat = ChatOpenRouter(
    model="particle-ai/particle-1:free",  # free tier model on OpenRouter (gemma free pool was rate-limited)
    system_prompt="You are a helpful assistant.",
)

# file?
with open('prompt.md', 'w') as f:
    f.write('I want you to act like {{ role }}')

# build our prompt
chat.system_prompt = ctl.interpolate_file(
  "prompt.md",
  variables={"role": "pytorch export"}
)
print(chat.system_prompt)
