---
name: finishing-a-development-branch
description: Use when implementation is complete, verification passes, and pull request review or merge work remains
---

# Finishing Development Through Pull Requests

## Overview

Complete development by creating or updating a pull request, moving review discussion into that pull request, iterating on feedback, merging after approval, and reporting final status.

**Core principle:** Verify first, collaborate in the pull request, merge only after approval.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## The Process

### Step 1: Verify Tests

Run the project's relevant test and build commands before creating, updating, or merging a pull request.

If tests fail:

```text
Tests failing (<N> failures). Must fix before PR completion:

[Show failures]

Cannot proceed until verification passes.
```

Stop and fix failures before continuing.

### Step 2: Gather PR Context

Check repository instructions for the required issue and pull request workflow. Stay platform-neutral:

- Use the repository's preferred CLI/API when available.
- If no automation is available, prepare the title/body and tell the human what remains manual.
- Include the issue reference when one exists.
- Use the current workspace and current branch context.

### Step 3: Create Or Update The Pull Request

The pull request body should include:

- Problem or issue summary.
- Approved brief spec.
- Task commits or implementation summary.
- Verification evidence.
- Open questions or follow-up risks, if any.

If a pull request already exists, update it instead of creating a duplicate.

### Step 4: Wait For Review

After the pull request is ready:

- Tell the human partner the pull request is ready for review.
- Do not merge without approval.
- If review tooling is available, check for review state and comments.
- If no review has arrived, stop and wait rather than inventing approval.

### Step 5: Iterate On Review

When review comments or questions arrive:

- **REQUIRED SUB-SKILL:** Use `receiving-code-review`.
- Read all comments before acting.
- Fix valid issues in follow-up commits.
- Answer questions in the relevant pull request threads when tooling supports it.
- Push or otherwise update the pull request.
- Re-run verification and repeat until approved.

### Step 6: Merge After Approval

After approval and passing verification:

- Use the repository's preferred merge method.
- If merge automation is unavailable or blocked, ask the human partner to merge and report the exact blocker.
- Update or close the issue when the repository workflow expects it.
- Report the merged pull request, final verification, and any remaining follow-up notes.

## Quick Reference

| State | Action |
|-------|--------|
| Verification failing | Fix before PR completion |
| No pull request exists | Create one using repo instructions |
| Pull request exists | Update it, do not duplicate |
| Review pending | Wait, do not merge |
| Comments received | Use `receiving-code-review`, fix or answer |
| Approved | Verify again, then merge |

## Common Mistakes

**Skipping verification**
- **Problem:** Broken pull request or broken merge.
- **Fix:** Verify before PR creation/update and before merge.

**Treating PR creation as completion**
- **Problem:** Human partner still needs review, questions answered, and merge handling.
- **Fix:** Stay in the PR loop until approved and merged.

**Top-level replies to inline comments**
- **Problem:** Review context gets lost.
- **Fix:** Reply in the relevant thread when tooling supports it.

**Merging without approval**
- **Problem:** Bypasses the main human collaboration stage.
- **Fix:** Wait for explicit approval.

## Red Flags

**Never:**
- Proceed with failing verification.
- Create a duplicate pull request for the same branch/work.
- Merge without approval.
- Force-push unless explicitly requested.
- Ignore review comments or questions.

**Always:**
- Use repository instructions for issue and pull request tooling.
- Keep the pull request body specific and evidence-backed.
- Answer questions in the pull request when possible.
- Re-run verification after review fixes.

## Integration

**Called by:**
- **subagent-driven-development** - After all task commits and reviews complete.
- **executing-plans** - After inline task execution completes.

**Pairs with:**
- **receiving-code-review** - Handles pull request comments and questions.
- **verification-before-completion** - Confirms evidence before success claims, commits, or PR updates.
