source ~/.config/fish/themes/kanagawa.fish
if status is-interactive
	alias .. "cd .."

	alias t 'tmux'
	alias vim 'nvim'
	alias ts 'tmux new-session -A -s $(basename $PWD)'
	alias tk 'tmux kill-server'


  alias stagingdb 'set -x AWS_PROFILE hv-stg; ~/Documents/hv/price/scripts/db-tunnel.sh staging'
  alias proddb 'set -x AWS_PROFILE hv-prod; ~/Documents/hv/price/scripts/db-tunnel.sh prod'
  alias proddbro 'set -x AWS_PROFILE hv-prod; ~/Documents/hv/price/scripts/db-tunnel.sh prod ro'
  alias redshift-prod 'set -x AWS_PROFILE hv-analytics-prod; ~/Documents/hv/price/scripts/redshift-analytics-tunnel.sh prod'

  alias vpndev 'sshuttle --dns -r homevision-dev-bastion 10.1.0.0/16'
  alias vpnstg 'sshuttle --dns -r homevision-stg-bastion 10.4.0.0/16'
  alias vpnprod 'sshuttle --dns -r homevision-prod-bastion 10.0.0.0/16'

  alias aidereditor 'aider --watch-files --no-auto-commits --no-dirty-commits --model flash'

  alias modss 'mods -R shell'
  alias search  'mods -m "gemini-flash-online"'

  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end
end
