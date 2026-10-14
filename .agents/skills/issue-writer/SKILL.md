---
name: issue-writer
description: GitHub issue body, bug report, issue title: Use when the user describes a problem, bug, or gap and wants a structured issue body, or asks to create an issue with gh.
---

# Writing GitHub Issue Bodies

Turn a described problem into a compact, structured issue body. Use only what the user provides plus light verification; never invent facts.

## Gather

- The user's description is the primary source.
- If the user names files, symbols, or errors, a light grep/glob may confirm them; include at most 2-3 `file:line` references, only when they add value.
- If reproduction steps or the actual error are essential but missing, ask one batched question before writing.

## Structure

Title: concise (<=70 chars), states the problem.

```markdown
## Summary
<what is wrong and where, 1-3 sentences>

## Steps to reproduce
1. <only real, known steps>

## Expected vs actual
- Expected: <...>
- Actual: <...>

## Impact
<who is affected and how>
```

Omit any section without real content; no placeholders. Quote error output verbatim.

## Publish

Write the body to `/tmp/issue-body.md`, show the title and body, then create:

```bash
gh issue create --title "<title>" --body-file /tmp/issue-body.md
```

Do not add labels, assignees, or `--repo` unless asked. Report the issue URL.
