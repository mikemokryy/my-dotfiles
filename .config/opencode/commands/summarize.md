---
description: Produce a concise, self-contained summary of the current conversation.
agent: summary
---

Summarize the current conversation into a concise, self-contained summary that someone who skipped this session can use to pick up where it left off.

Cover, in order:
- **Goal**: what the user originally wanted
- **What was done**: the steps, commands, and changes made
- **Key decisions / results**: choices and their rationale, with file:line references where relevant
- **Open items / next steps**: unfinished tasks or suggested follow-ups

Write in the user's language. Do not invent details that are not in the conversation. Only include code snippets if they are essential.

Optional requested scope or output target: $ARGUMENTS
