---
name: issue-writer
description: GitHub issue body, bug report, feature request, issue title: Use when the user describes a problem, bug, gap, or feature request and wants an issue body matching the current repo's issue forms, or asks to create an issue with gh.
---

# Writing GitHub Issue Bodies

Turn a described problem into an issue that matches the repository's issue template. Use only what the user provides plus light verification; never invent facts.

## Find the template

Resolve the repository root (`git rev-parse --show-toplevel`, or the current directory outside git) and read `.github/ISSUE_TEMPLATE/`.

- Pick the bug form for defects, regressions, or broken behavior, and the feature form for new functionality or improvements. Match by filename first (`bug_report*`, `feature_request*`), then by the form's `name`/`description`; ignore `config.yml`.
- If several forms fit, ask one short question. If the repo has only legacy `.md` templates, use their headings as sections.
- The form's front matter is the source of truth for title prefix, labels, type, assignees, and project; its `body` fields are the source of truth for section labels and order.

If the repository has no issue templates, use the fallback structure below, derived from `kokimoki-server`. The fallback has no labels, type, assignees, or project — do not invent them.

## Gather

- The user's description is the primary source.
- If the user names files, symbols, or errors, a light grep/glob may confirm them; include at most 2-3 `file:line` references, only when they add value.
- Fill every required field. Include optional fields only when real content exists; omit them otherwise — no placeholders, no "No response".
- If a required field cannot be filled, ask one batched question before writing.

## Body

Use each template field label as a `###` heading, in template order.

Fallback bug report:

```markdown
### Expected Behavior
<...>

### Actual Behavior
<...>

### Steps to Reproduce the Problem
1. <only real, known steps>

### Anything else?
<screenshots, logs, or extra context; omit if none>
```

Fallback feature request:

```markdown
### Is your feature request related to a problem?
<...>

### Describe the solution you'd like
<...>

### Describe alternatives you've considered
<...>

### Additional context
<...>
```

Quote error output verbatim. Use the template's title prefix (for example `[Bug]: ` or `[Feature]: `) when present, and keep the title at 70 characters or less.

## Publish

Write the body to `/tmp/issue-body.md` and show the proposed title and body. Create the issue with the template's metadata, not the example values:

```bash
gh issue create \
  --title "[Bug]: <title>" \
  --body-file /tmp/issue-body.md \
  --label "low" \
  --assignee "MikhailoMokryy" \
  --type "Bug"
```

Add `--type` only when `gh issue create --help` lists it. Use `--project "<title>"` for a project title; for an `owner/number` entry, create the issue first, then add it:

```bash
gh project item-add <number> --owner <owner> --url "<issue-url>"
```

If the project add fails for missing scope, report the issue URL and the failing command; do not block issue creation. Do not add labels, assignees, or projects that the template does not specify. Report the final issue URL.
