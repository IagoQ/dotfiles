set -U fish_greeting

set GOPATH $HOME/go
export GONOSUMDB=gitlab.com/qubit-capitals/backend/go

fish_add_path $GOPATH/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.cargo/bin

alias fixkeyboard "echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode"

alias .. "cd .."

alias t 'tmux'
alias ts 'tmux new-session -A -s $(basename $PWD)'
alias tk 'tmux kill-server'
alias ed 'echo $(basename $PWD)'

alias gce 'gh copilot explain'
alias gcs 'gh copilot suggest'

# fish_config theme save "TokyoNight Night"

status --is-interactive; and /home/iago/.rbenv/bin/rbenv init - fish | source
