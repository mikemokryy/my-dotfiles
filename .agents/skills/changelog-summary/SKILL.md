---
name: changelog-summary
description: Release notes, changelog summary, Unreleased, and latest version: Use when asked to explain CHANGELOG.md changes in consumer-friendly bullet points.
---

# Consumer Changelog Summary

Turn the applicable changelog into a concise, accurate summary for non-technical readers. This skill is read-only: do not add, edit, or reorganize changelog entries.

## Select The Source

1. Honor an explicitly named changelog, app, package, or repository scope.
2. In a monorepo, use the changelog owned by the affected app or package. Do not default to the repository root when a nearer applicable changelog exists.
3. Use `Unreleased` when it contains entry bullets. If it is empty or absent, use the newest released version instead.
4. Preserve the project's release naming. Do not invent a version, date, or release status.
5. If no applicable changelog or usable section exists, say so plainly rather than guessing from the Git diff.

## Write For Consumers

- Summarize only behavior stated in the selected changelog section.
- Describe outcomes, capabilities, and fixes in everyday language.
- Replace implementation names, file paths, APIs, routes, classes, and libraries with their user-facing effect unless the name is essential for a user action.
- Exclude internal refactors, CI, dependency, build, and tooling changes unless the changelog states a direct user impact.
- Keep distinct user outcomes as separate bullets. Combine duplicates.
- Do not overstate certainty or claim a benefit that the changelog does not support.

## Output Format

Return only a short heading followed by flat bullet points. Use `Current changes` for `Unreleased`, or `Latest release: <release label>` for a released version.

```markdown
Current changes

- Links now open in the appropriate app or browser more reliably.
- PDF links are handled consistently.
```

When the selected section has no consumer-facing entries, return:

```markdown
No consumer-facing changes are listed.
```
