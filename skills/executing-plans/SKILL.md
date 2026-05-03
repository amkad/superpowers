---
name: executing-plans
description: Use when executing an approved temporary implementation plan without subagent support
---

# Executing Plans

## Overview

Execute an approved temporary implementation plan in the current workspace. Prefer `subagent-driven-development` when subagents are available; use this skill when execution must stay inline.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## The Process

### Step 1: Review The Temporary Plan

1. Read the approved brief spec and plan from the current conversation, issue, or pull request discussion.
2. Review critically for missing acceptance criteria, unclear task boundaries, and missing verification.
3. If concerns exist, raise them with the human partner before starting.
4. If clear, create TodoWrite and proceed.

### Step 2: Execute Tasks

For each task:

1. Mark it in progress.
2. Follow each step exactly.
3. Use `test-driven-development` for behavior changes.
4. Run the specified verification.
5. Commit only that task's files.
6. Mark the task completed.

### Step 3: Review Checkpoints

After every 1-3 tasks, request code review if the work is complex or risk is accumulating. Fix Critical and Important issues before continuing.

### Step 4: Complete Development

After all tasks are complete and verified:

- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use `finishing-a-development-branch`.
- Follow that skill to create or update the pull request and enter the review loop.

## When to Stop and Ask for Help

Stop immediately when:

- A blocker prevents progress.
- The plan has critical gaps.
- Verification fails repeatedly.
- Review feedback conflicts with the approved brief spec.

Ask for clarification rather than guessing.

## Red Flags

**Never:**
- Execute an unapproved plan.
- Skip verification for a task.
- Batch unrelated tasks into one commit.
- Move to pull request completion with failing tests.

**Always:**
- Review the plan before implementation.
- Preserve one commit per task.
- Keep the current workspace as the working context.
- Stop on blockers instead of inventing requirements.

## Integration

**Required workflow skills:**
- **superpowers:writing-plans** - Creates the temporary plan this skill executes.
- **superpowers:test-driven-development** - Required for behavior changes.
- **superpowers:finishing-a-development-branch** - Creates or updates the pull request after all tasks.
