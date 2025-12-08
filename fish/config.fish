source ~/.config/fish/themes/kanagawa.fish

set -gx EDITOR nvim
set -gx BASH_DEFAULT_TIMEOUT_MS 1000000

if status is-interactive
	alias .. "cd .."

	alias t 'tmux'
	alias ts 'tmux new-session -A -s $(basename $PWD)'
	alias tk 'tmux kill-server'
	alias vim 'nvim'

  alias jjs 'jj status'
  alias jjd 'jj diff'

  #moves nearest bookmark to current position
  function jjtug
      jj bookmark move --from (jj log -r 'heads(::@- & bookmarks())' -T 'bookmarks' --no-graph | head -1) --to @-
  end

  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end
end







function tw
    set current_dir (basename $PWD)
    
    if test (count $argv) -eq 0
        set branch_name (git branch --show-current)
        if test -z "$branch_name"
            echo "Error: Not on a branch or not in a git repo"
            return 1
        end
    else
        set branch_name $argv[1]
    end
    
    # Convert branch name to safe session/directory name
    set safe_name (string replace -a "/" "-" $branch_name)
    set worktree_path "../$safe_name-wt"
    
    # Check if branch is already checked out somewhere
    set existing_worktree (git worktree list | grep "\[$branch_name\]" | awk '{print $1}')
    
    if test -n "$existing_worktree"
        echo "Branch '$branch_name' is already checked out at: $existing_worktree"
        read -P "Switch to existing worktree? [Y/n]: " choice
        
        if test "$choice" != "n"; and test "$choice" != "N"
            cd $existing_worktree
            tmux new-session -A -s $safe_name
            return 0
        else
            echo "Operation cancelled."
            return 1
        end
    else
        # Check if branch exists
        if git show-ref --verify --quiet refs/heads/$branch_name
            echo "Branch '$branch_name' exists, checking out..."
            git worktree add $worktree_path $branch_name
        else
            echo "Creating new branch '$branch_name'..."
            git worktree add $worktree_path -b $branch_name
        end
        
        and cd $worktree_path
        and tmux new-session -A -s $safe_name
    end
end

function twk
    if test (count $argv) -eq 0
        # Auto-detect what to clean up
        set git_dir (git rev-parse --git-dir 2>/dev/null)
        
        if test -z "$git_dir"
            echo "Error: Not in a git repository"
            return 1
        end
        
        # Check if current directory is a worktree
        if test -f "$git_dir" # .git is a file, not directory (worktree)
            # We're in a worktree
            set worktree_path $PWD
            set session_name (basename $PWD | string replace "-wt" "")
        else
            # We're in main repo, use current branch
            set branch_name (git branch --show-current)
            set session_name $branch_name
            set worktree_path "../$branch_name-wt"
        end
    else
        # Specific session/branch provided
        set session_name $argv[1]
        set worktree_path "../$session_name-wt"
    end
    
    echo "Cleaning up: $session_name"
    
    # Kill session
    tmux kill-session -t $session_name 2>/dev/null
    and echo "✓ Session killed"
    
    # Move out if we're in the worktree
    if string match -q "*$worktree_path*" $PWD
        cd (git rev-parse --show-toplevel)
        echo "✓ Moved to main repo"
    end
    
    # Remove worktree
    git worktree remove $worktree_path --force 2>/dev/null
    and echo "✓ Worktree removed"
    or echo "• Worktree not found"
end

function jqai
    if test (count $argv) -lt 2
        echo "Usage: jqai <json_file> <description>"
        echo "Example: jqai data.json \"extract all names from the users array\""
        return 1
    end
    
    set json_file $argv[1]
    set description $argv[2..-1]
    
    if not test -f "$json_file"
        echo "Error: File '$json_file' not found"
        return 1
    end
    
    # Create a prompt with examples and clear instructions for JSON output
    set prompt "You are a jq query generator. Given a JSON file and a description, generate ONLY the jq query.

Examples:
- Description: \"extract all names from the users array\"
  Output: {\"query\": \".users[] | .name\"}
  
- Description: \"get the count of items\"
  Output: {\"query\": \". | length\"}
  
- Description: \"filter objects where status is active\"
  Output: {\"query\": \".[] | select(.status == \\\"active\\\")\"}
  
- Description: \"get all keys from the object\"
  Output: {\"query\": \"keys[]\"}

JSON file: @$json_file
Description: $description

Return a JSON object with a single \"query\" field containing the jq query. Do not include any other text or explanation."
    
    # Get the response and parse JSON
    set response (claude -p "$prompt")
    
    if test -z "$response"
        echo "Error: Failed to generate jq query"
        return 1
    end
    
    # Extract the query from JSON response using jq itself
    set jq_query (echo "$response" | jq -r '.query' 2>/dev/null)
    
    if test -z "$jq_query" -o "$jq_query" = "null"
        # Fallback: try to use the response directly if it's not JSON
        set jq_query (echo "$response" | string trim)
    end
    
    echo "Generated jq query: $jq_query"
    echo "Applying to $json_file..."
    echo
    
    # Run the jq query with error handling
    jq "$jq_query" "$json_file"
    if test $status -ne 0
        echo
        echo "Error: The generated query failed. You may need to adjust your description."
        return 1
    end
end


# opencode
fish_add_path /home/iagoq/.opencode/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
