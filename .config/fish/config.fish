set -U fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

set -gx EDITOR nvim

abbr l ll -a
abbr b bat
abbr c cat
abbr a amp --ide

alias cat='bat'

alias fd='fdfind'

alias vi='nvim'
alias vim='nvim'

abbr n nvim
abbr v nvim

abbr copy 'xclip -selection clipboard'
abbr clip 'xclip -selection clipboard'

abbr t termdown
abbr f yazi

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
