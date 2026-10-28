---
description: Create a GitHub issue from the current repo's issue form template.
agent: gh-publisher
---

Follow the `issue-writer` skill. Find the issue templates in the current repository's `.github/ISSUE_TEMPLATE/`; pick the bug report or feature request form, fill its fields, and create the issue with `gh issue create` using the template's front matter. If the repo has no templates, use the skill's fallback structure.

Problem description: $ARGUMENTS

Show the proposed title and body before creating. Report the issue URL.
