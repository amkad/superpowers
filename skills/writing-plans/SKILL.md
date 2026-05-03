---
name: writing-plans
description: Use when approved requirements or a brief spec need to become implementation tasks before touching code
---

# Writing Temporary Implementation Plans

## Overview

Write a temporary implementation plan in the current conversation, issue comment, or pull request discussion. The plan gives subagents exact task boundaries, files, verification commands, and commit expectations. Do not create repository plan artifacts by default.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

## Scope Check

If the approved brief spec covers multiple independent subsystems, suggest splitting the work. Each plan should produce working, testable software and a reviewable pull request on its own.

## File Structure

Before defining tasks, map which files will be created or modified and what each one is responsible for.

- Design units with clear boundaries and well-defined interfaces.
- Prefer smaller focused files when the existing codebase already supports that style.
- Follow established patterns in existing codebases.
- Include targeted cleanup only when it supports the planned work.

## Task Granularity

Each task should be a coherent commit boundary:

- Write the failing test or workflow check.
- Run it and verify the expected failure.
- Implement the minimal change.
- Run verification and confirm it passes.
- Commit only that task's files after the workflow's review gate passes.

## Plan Header

Every temporary plan starts with this header:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `subagent-driven-development` (recommended) or `executing-plans` to implement this plan task-by-task.

**Goal:** [One sentence describing what this builds]
**Brief Spec:** [Short pointer to the approved conversation, issue, or PR context]
**Architecture:** [2-3 sentences about approach]
**Tech Stack:** [Key technologies/libraries]
```

## Task Structure

````markdown
### Task N: [Task Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

- [ ] **Step 5: Prepare the task commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```

For `subagent-driven-development`, do not run this commit step until requirements compliance and code quality review both pass. For `executing-plans`, commit after the task verification and any configured review checkpoint pass.
````

## No Placeholders

Never write:

- "TBD", "TODO", "implement later", or "fill in details".
- "Add appropriate error handling" without explaining the actual boundary behavior.
- "Write tests for the above" without concrete test code or commands.
- "Similar to Task N" instead of repeating the needed details.
- Steps that require hidden context from a separate artifact.

## Self-Review

Before execution, review the temporary plan:

1. **Requirement coverage:** Each acceptance criterion maps to a task.
2. **Placeholder scan:** No vague steps or missing commands remain.
3. **Commit boundaries:** Each task can be committed independently after its review gate passes.
4. **PR readiness:** The final task leaves enough evidence for a pull request.

Fix issues inline before execution.

## Execution Handoff

After presenting the temporary plan:

- If the human asked you to implement, proceed with the appropriate execution skill.
- If the human only asked for planning, stop and ask whether to execute.
- Prefer `subagent-driven-development` when subagents are available.
- Use `executing-plans` for inline execution or platforms without subagent support.

## Red Flags

**Never:**
- Create a repository plan artifact unless explicitly requested.
- Start implementation before the brief spec is approved.
- Combine unrelated tasks into one commit.
- Leave task verification unspecified.

**Always:**
- Keep plans temporary by default.
- Treat each task as one reviewable commit.
- Include exact file paths and verification commands.
- Preserve the approved scope.
