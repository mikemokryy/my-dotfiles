---
description: Apply code review / review agent findings to the codebase with skepticism. Paste the FINDINGS after the command; every claim is verified against the code before any change is made.
agent: build
---

You are applying a new batch of code review findings. Take them with healthy skepticism: findings are hypotheses, not facts. Always verify with the actual codebase before making any change.

Use the `review-findings` skill for the full workflow. In short:

1. Ingest the pasted findings below, one distinct issue per row.
2. For every finding, verify it directly against the code before judging it: locate the referenced files/lines, read the code and its callers/tests, confirm the defect actually exists, and rule out the finding being stale or wrong.
3. Classify each finding as CONFIRMED, PARTIALLY TRUE, FALSE POSITIVE, or STALE. Apply changes only for confirmed findings, with minimal idiomatic edits plus tests where the project tests that area.
4. Re-verify your own edits (reread in context, run relevant tests / lint / typecheck).
5. Report per-finding verdicts with evidence (`file:line`), what you changed, and which findings you rejected and why.

The review findings to process:

$ARGUMENTS
