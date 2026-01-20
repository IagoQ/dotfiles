# spec-workflow

Spec creation, sprint breakdown, coordinated implementation, and feature development with specialized agents for Claude Code.

## Commands

### `/spec-workflow:create-spec [idea]`

Guided PRD-style spec creation. Walks through:

1. **Discovery** - Understand what needs to be built
2. **Codebase Exploration** - Explore existing code patterns (if applicable)
3. **Requirements Gathering** - Ask clarifying questions about scope, edge cases, success criteria
4. **Solution Approaches** - Design multiple approaches with trade-offs
5. **Draft Specification** - Write comprehensive spec document
6. **Refinement** - Iterate until approved

Outputs: `<project-name>-spec.md`

### `/spec-workflow:breakdown-spec <path/to/spec.md>`

Break down a spec into sprints and atomic tickets. Each ticket is a commitable piece of work with validation criteria. Each sprint results in demoable software.

Outputs: `<spec-filename>-sprint-plan.md`

### `/spec-workflow:implement-spec <path/to/sprint-plan.md>`

Execute a sprint plan with coordinated subagents. Implements tickets sequentially, validates each, and runs sprint reviews.

### `/spec-workflow:feature-dev [feature]`

Guided feature development with codebase understanding and architecture focus. Walks through:

1. **Discovery** - Understand what needs to be built
2. **Codebase Exploration** - Launch code-explorer agents to understand patterns
3. **Clarifying Questions** - Resolve all ambiguities before designing
4. **Architecture Design** - Launch code-architect agents for multiple approaches
5. **Implementation** - Build the feature with user approval
6. **Quality Review** - Launch code-reviewer agents for quality assurance
7. **Summary** - Document what was accomplished

## Agents

### `code-explorer`

Deeply analyzes existing codebase features by tracing execution paths, mapping architecture layers, understanding patterns and abstractions, and documenting dependencies.

### `code-architect`

Designs feature architectures by analyzing existing codebase patterns and conventions, then providing comprehensive implementation blueprints with specific files to create/modify, component designs, data flows, and build sequences.

### `code-reviewer`

Reviews code for bugs, logic errors, security vulnerabilities, code quality issues, and adherence to project conventions, using confidence-based filtering to report only high-priority issues.

## Installation

```bash
# Add as local plugin
claude --plugin-dir ~/.claude/plugins/spec-workflow

# Or install from GitHub (if published)
/plugin install spec-workflow
```

## Workflow

```
create-spec → breakdown-spec → implement-spec
     ↓              ↓               ↓
  spec.md    sprint-plan.md    working code

# Or for single features:
feature-dev → working code
```
