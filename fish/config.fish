set -U fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    #THEME
    set -l onedark_options '-b'

    if set -q VIM
        # Using from vim/neovim.
        set onedark_options "-256"
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title; true; end
        set onedark_options "-256"
    end

    set_onedark $onedark_options
end

set GOPATH $HOME/go
fish_add_path $GOPATH/bin
fish_add_path /usr/local/go/bin

alias fixkeyboard "echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode"

alias .. "cd .."

alias gs "git status"
alias gc "git commit -m"
