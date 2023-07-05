set -U fish_greeting

set GOPATH $HOME/go
fish_add_path $GOPATH/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.cargo/bin


alias fixkeyboard "echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode"

alias .. "cd .."

alias t "tmux"
alias gs "git status"
alias gc "git commit -m"

# fish_config theme save "TokyoNight Night"
