---
description: Fetch PR review comments and fix confirmed findings via the review-findings workflow. Argument: PR number or URL; defaults to the current branch's PR.
agent: pr-reviewer
---

Apply the review feedback on a pull request.

Target: $ARGUMENTS

## Resolve the PR

- If the argument is a full URL, parse `owner/repo` and the PR number from it.
- If it is a bare number, get `owner/repo` from `git remote get-url origin` (handle both `github.com/owner/repo.git` and `git@github.com:owner/repo.git`).
- If empty, use the current branch's PR: `gh pr view --json number,title,url,headRefName,baseRefName,state`.
- Confirm with `gh pr view <number> --repo <owner>/<repo> --json number,title,url,headRefName,baseRefName,state`. If no PR resolves, stop and ask which PR to use.

## Fetch all review feedback

Use read-only calls only, and paginate:

- Inline review comments: `gh api repos/<owner>/<repo>/pulls/<number>/comments --paginate --jq '.[] | {id, user: .user.login, path, line, original_line, side, start_line, position, diff_hunk, body, in_reply_to_id, commit_id, created_at}'`
- Review summaries: `gh api repos/<owner>/<repo>/pulls/<number>/reviews --paginate --jq '.[] | {id, user: .user.login, state, body, submitted_at}'`
- Conversation comments: `gh api repos/<owner>/<repo>/issues/<number>/comments --paginate --jq '.[] | {id, user: .user.login, body, created_at}'`

## Normalize into FINDINGS

- One finding per inline comment thread: group replies by `in_reply_to_id` (root comment id).
- For each thread include `path:line`, the quoted `diff_hunk` context, the comment body, and the author.
- Treat `position: null` or `line != original_line` as an outdated candidate; the skill's STALE check decides.
- Include review summaries and conversation comments only when they contain an actionable request.
- Number findings F1, F2, ... and drop duplicates.

## Apply with the review-findings workflow

Follow the `review-findings` skill for the full workflow:

1. Verify every finding against the current checkout before judging it; locate the referenced code and read callers and tests.
2. Classify each finding as CONFIRMED, PARTIALLY TRUE, FALSE POSITIVE, or STALE.
3. Apply only confirmed fixes, minimal and idiomatic, with tests where the project tests that area.
4. Run the project's verification (tests, lint, typecheck as available).
5. Report per-finding verdicts with `file:line` evidence, changes applied, and rejected findings with evidence.

If there are no review comments, say so plainly and stop. Do not reply to or resolve GitHub threads, and do not commit, push, or modify repository history.
