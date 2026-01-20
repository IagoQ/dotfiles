#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON input
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
context_window=$(echo "$input" | jq '.context_window // {}')

# Get current folder name (basename only)
if [ -n "$current_dir" ]; then
    folder_name=$(basename "$current_dir")
    cd "$current_dir" 2>/dev/null || true
else
    folder_name=$(basename "$(pwd)")
fi

# Calculate context percentage
context_pct=""
usage=$(echo "$context_window" | jq '.current_usage')
if [ "$usage" != "null" ] && [ -n "$usage" ]; then
    current=$(echo "$usage" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')
    size=$(echo "$context_window" | jq '.context_window_size // 200000')
    if [ "$current" -gt 0 ] && [ "$size" -gt 0 ]; then
        pct=$((current * 100 / size))
        context_pct="${pct}%"
    fi
fi

# Get git branch
git_branch=""
if git rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || "")
    if [ -n "$branch" ]; then
        git_branch="$branch"
    fi
fi

# Colors
BLUE='\033[01;34m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
MAGENTA='\033[01;35m'
RESET='\033[00m'

# Build status line: folder | model | context% | git-branch
output="${BLUE}${folder_name}${RESET}"

if [ -n "$model_name" ]; then
    output="${output} | ${YELLOW}${model_name}${RESET}"
fi

if [ -n "$context_pct" ]; then
    output="${output} | ${GREEN}${context_pct}${RESET}"
fi

if [ -n "$git_branch" ]; then
    output="${output} | ${MAGENTA}${git_branch}${RESET}"
fi

printf "$output"