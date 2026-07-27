---
description: Summarize an Unreleased changelog section or latest release for non-technical readers.
agent: change-auditor
---

Follow the `changelog-summary` skill. Produce a consumer-facing summary from the applicable `CHANGELOG.md`.

Requested scope: $ARGUMENTS

Use a non-empty `Unreleased` section; otherwise use the newest released version. Do not inspect or summarize the Git diff, edit files, or include implementation details. Reply only with the required heading and flat bullet points.
