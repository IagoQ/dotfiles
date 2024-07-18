set --export PYENV_ROOT /home/iagoq/.pyenv
set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1

# Enable virtualenv autocomplete
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

