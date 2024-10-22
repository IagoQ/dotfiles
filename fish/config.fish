set -U fish_greeting
set GOPATH $HOME/go

fish_add_path $GOPATH/bin
fish_add_path /usr/local/go/bin

# fish_add_path $HOME/.cargo/bin
# source "$HOME/.cargo/env.fish"

source $HOME/.config/fish/themes/kanagawa.fish

if status is-interactive

	alias .. "cd .."

	alias t 'tmux'
	alias ts 'tmux new-session -A -s $(basename $PWD)'
	alias tk 'tmux kill-server'
end


# # pyenv init
# if command -v pyenv 1>/dev/null 2>&1
#   pyenv init - | source
# end
