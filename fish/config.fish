source ~/.config/fish/themes/kanagawa.fish
if status is-interactive
	alias .. "cd .."

	alias t 'tmux'
	alias ts 'tmux new-session -A -s $(basename $PWD)'
	alias tk 'tmux kill-server'
end
