---
description: Guided PRD-style spec creation with codebase awareness
argument-hint: Optional project/feature idea
---

# Create Specification

You are helping a developer create a comprehensive PRD-style specification document. Follow a systematic approach: understand what they want to build, explore the codebase if relevant, gather all requirements, design the solution, then write a detailed spec.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding. Ask questions early.
- **Understand before specifying**: Read and comprehend existing code patterns first (if existing codebase)
- **Read files identified by agents**: When launching agents, ask them to return lists of the most important files to read. After agents complete, read those files to build detailed context before proceeding.
- **Comprehensive but actionable**: The spec should be detailed enough for implementation tickets
- **Use TodoWrite**: Track all progress throughout

---

## Phase 1: Discovery

**Goal**: Understand what needs to be specified

Initial request: $ARGUMENTS

**Actions**:
1. Create todo list with all phases
2. If the idea is unclear or no arguments provided, ask user for:
   - What problem are they solving?
   - What should this project/feature do?
   - Any constraints or requirements?
3. Summarize understanding and confirm with user

---

## Phase 2: Codebase Exploration

**Goal**: Understand relevant existing code and patterns (if applicable)

**Actions**:
1. Ask user: **Is this for an existing codebase or a greenfield project?**
2. If existing codebase, launch 2-3 `code-explorer` agents in parallel. Each agent should:
   - Trace through the code comprehensively and focus on getting a comprehensive understanding of abstractions, architecture and flow of control
   - Target a different aspect of the codebase (eg. similar features, architectural patterns, integration points)
   - Include a list of key files to read

   **Example agent prompts**:
   - "Find features similar to [feature] and trace through their implementation comprehensively"
   - "Map the architecture and abstractions for [feature area], tracing through the code comprehensively"
   - "Identify integration points, APIs, and extension mechanisms relevant to [feature]"

3. Once the agents return, read all files identified by agents to build deep understanding
4. Present comprehensive summary of findings and patterns discovered
5. If greenfield, note technology preferences and skip to Phase 3

---

## Phase 3: Requirements Gathering

**Goal**: Fill in all gaps and resolve ambiguities before designing

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Review the codebase findings (if any) and original feature request
2. Identify underspecified aspects and **present all questions to the user in a clear, organized way**:
   - **Scope**: What's in scope? What's explicitly out of scope (non-goals)?
   - **Users**: Who will use this? Different user types or roles?
   - **Edge cases**: What unusual situations should be handled?
   - **Success criteria**: How will we know this is working correctly?
   - **Dependencies**: External services, libraries, or prerequisites?
   - **Constraints**: Performance, security, compatibility requirements?
3. **Wait for answers before proceeding to solution design**

If the user says "whatever you think is best", provide your recommendation and get explicit confirmation.

---

## Phase 4: Solution Approaches

**Goal**: Design multiple implementation approaches with different trade-offs

**Actions**:
1. Launch 2-3 `code-architect` agents in parallel with different focuses:
   - Minimal/simple approach (smallest scope, maximum reuse)
   - Clean architecture approach (maintainability, elegant abstractions)
   - Pragmatic balance (speed + quality)

2. Review all approaches and form your opinion on which fits best for this specific project
3. Present to user:
   - Brief summary of each approach
   - Trade-offs comparison
   - **Your recommendation with reasoning**
   - Concrete implementation differences
4. **Ask user which approach they prefer**

---

## Phase 5: Draft Specification

**Goal**: Write the comprehensive spec document

**DO NOT START WITHOUT USER APPROVAL ON APPROACH**

**Actions**:
1. Wait for explicit user approval on chosen approach
2. Write the spec to `<project-name>-spec.md` with this structure:

```markdown
# <Project Name> Specification

## Problem Statement
[Clear description of the problem being solved]

## Goals / Success Criteria
- [Measurable outcome 1]
- [Measurable outcome 2]

## Non-Goals
- [What we're explicitly not doing]

## Requirements

### Functional Requirements
- [FR1: Description]
- [FR2: Description]

### Non-Functional Requirements
- [NFR1: Performance, security, etc.]

## Technical Design

### Architecture Overview
[High-level description of the solution architecture]

### Components
| Component | Responsibility |
|-----------|----------------|
| ... | ... |

### Files to Create/Modify
| File | Action | Purpose |
|------|--------|---------|
| ... | Create/Modify | ... |

### Key Interfaces / Data Models
[Code blocks showing interfaces, types, schemas]

### Integration Points
[How this connects to existing systems]

## Open Questions / Risks
- [Unresolved question 1]
- [Risk 1 and mitigation]
```

3. The spec should be detailed enough so that we can create atomic implementation tickets and sprints from it
4. Present the draft to user

---

## Phase 6: Refinement

**Goal**: Iterate until user is satisfied

**Actions**:
1. Ask user for feedback:
   - Anything missing?
   - Anything to change or clarify?
   - Any sections that need more detail?
2. Address feedback and update spec
3. Repeat until user approves the final spec

---

## Phase 7: Summary

**Goal**: Document what was accomplished

**Actions**:
1. Mark all todos complete
2. Summarize:
   - What was specified
   - Key decisions made
   - Location of spec file
   - Suggested next steps

---
