---
description: Write a structured PR body from the current branch changes as copy-paste-ready markdown in a fenced block.
---

Write a structured PR body for the current branch. Optional base branch: $ARGUMENTS

Base: the argument above, else `git symbolic-ref --short refs/remotes/origin/HEAD` (strip `origin/`), fallback `main`. If neither resolves, list remote branches (`git branch -r`) and pick the default, or ask. Read `git log --oneline <base>..HEAD` and `git diff <base>...HEAD --stat`, then group changes by intent (logical chunks), not per file.

Reply with only this markdown, wrapped in a single fenced code block so the raw syntax survives copying from the terminal:

## Summary
<why this change exists, 1-3 sentences>

## Changes
- <intent-grouped bullet>

## Verification
- <tests or checks actually run; "Not run" if unknown>

## Notes
<breaking changes, follow-ups; omit if none>

Wrap the whole body in one backtick code fence with no language tag, and output nothing outside the fence. If the body itself contains a code fence, make the outer fence longer so it stays intact. The terminal renders the reply, so without the fence the `##` markers are hidden and copy as plain text; the fence preserves them.

Describe behavior and intent, not file lists. No secrets, tokens, or internal URLs. Exclude CI/tooling noise unless user-facing. Omit any section without real content.
