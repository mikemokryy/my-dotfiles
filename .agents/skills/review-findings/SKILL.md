---
name: review-findings
description: Apply results of a code review and review agent findings to the codebase with healthy skepticism. Use when the user pastes FINDINGS, review agent output, code review comments, or review feedback and wants changes made. Verify every claim against the actual code before editing; reject false positives with evidence.
---

# Applying Review Findings With Skepticism

Review findings are hypotheses, not facts. They may be wrong, stale, targeted at code that no longer exists, or confidently phrased while pointing at the wrong location. Do not rubber-stamp them. Verify each finding against the actual codebase, and only apply changes that hold up.

## Core Principle

Every finding must be confirmed by direct evidence in the code before it is applied. When in doubt, read the code. Never apply a fix "because the review said so" — you need to see the defect with your own eyes.

## Workflow

### 1. Ingest and list the findings

Collect every distinct finding from the input (the `FINDINGS`). Give each a short id (F1, F2, ...). Group duplicates. Note any that reference the same file or function.

### 2. Verify each finding against the codebase (mandatory)

For every finding, gather direct evidence before judging it:

- **Locate the referenced code.** Resolve the file path, function, or line the finding points to. If it points nowhere, that is a red flag: the finding may be stale or hallucinated. Search the codebase (grep/glob/read) for the described symbol or behavior when paths look wrong.
- **Confirm the claim.** Reproduce the described defect or identify the described pattern in the current code. Capture concrete evidence: `file:line` and a quote of the relevant code.
- **Check the context.** Read surrounding code, callers, tests, and any API contracts. A fix that looks right in isolation can break a caller, contradict expected behavior, or duplicate an existing utility.
- **Check recency.** If the git history or current code shows the issue is already fixed or superseded, mark it so.

### 3. Judge each finding

Classify every finding into one of:

- **CONFIRMED** — the defect is real in the current code and the suggested (or your own) fix is correct and minimal.
- **PARTIALLY TRUE** — the finding points at a real concern but the description, location, or proposed fix is inaccurate; specify the corrected understanding.
- **FALSE POSITIVE** — the claim does not hold against the current code; explain why with evidence.
- **STALE** — it was valid but no longer applies (already fixed, code removed, behavior changed); note what changed.

Do not apply changes for findings that are FALSE POSITIVE or STALE.

### 4. Apply changes for confirmed findings

- Make the smallest, most idiomatic edit that resolves the defect, consistent with the surrounding code.
- Update or add tests when the finding surfaces a behavior that should be locked down, if the project tests that area.
- Do not fix unrelated issues you spot unless they are directly in the fix's blast radius; note them separately instead.

### 5. Verify your own changes

Re-read each edit in context, then run the relevant tests / lint / typecheck as available. Confirm your change does not introduce a regression.

## Output Format

Return a report:

```markdown
## Verdict per finding

| # | Finding summary | Verdict | Evidence |
|---|-----------------|---------|----------|
| F1 | ... | CONFIRMED | `src/foo.ts:42`, `<quote>` |
| F2 | ... | FALSE POSITIVE | `src/bar.ts` implements it correctly: ... |

## Changes applied
- `src/foo.ts`: `<what changed>` (F1)

## Rejected / ignored and why
- F2: evidence of why it does not hold.
```

If all findings were rejected, say so plainly with the evidence for each — do not invent edits to appear productive.
