---
description: Execute a sprint plan with coordinated subagents
argument-hint: path/to/sprint-plan.md
---

Implement the spec at: $ARGUMENTS

This is a structured, long-running implementation process. You are the **coordinator**.

## Workflow

For each sprint in the spec:

1. **Execute tickets sequentially** - For each ticket in the sprint:
   - Launch a subagent (Task tool) to implement that specific ticket
   - Prompt the subagent to test/validate their changes if possible (e.g., nvim headless mode, unit tests, type checks)
   - Once complete, the subagent marks the ticket as done in the plan file with resolution notes
   - Wait for completion before moving to next ticket

2. **Sprint review** - After all tickets in a sprint are done:
   - Launch a `code-reviewer` agent to review the sprint's changes
   - Launch an executor subagent to implement any suggestions from the review

3. **Iterate** - Move to the next sprint and repeat

## Guidelines

- One ticket at a time, sequential execution
- Each subagent should mark their ticket done with notes directly in the spec file
- Validation is critical - tests, type checks, manual verification
- You orchestrate, subagents implement
