fish_add_path $HOME/.local/bin
fish_add_path $HOME/.composer/vendor/bin
fish_add_path $HOME/.phpenv/bin
fish_add_path $HOME/.phpenv/shims

set -U fish_greeting
set -U EDITOR nvim

set -g fish_key_bindings fish_vi_key_bindings

fzf --fish | source

# Base
abbr l ll -a
abbr tq ~/Downloads/TitanQuestAE_Linux/start.sh

# Neovim
alias vi='nvim'
alias vim='nvim'

abbr n nvim
abbr v nvim

# Clipboard
abbr copy 'xclip -selection clipboard'
abbr clip 'xclip -selection clipboard'

# Node / NPM / NPX
abbr nr 'npm run'
abbr nrd 'npm run dev'

abbr cnv npx shadcn-vue@latest
abbr cns npx shadcn-svelte@next

# Files
abbr f 'nnn -d -e -H -r'

# Symfony
abbr s symfony
abbr sc 'symfony console'

# Taskfile
alias task go-task

abbr t task
abbr td --position anywhere --set-cursor 'task dev:%'
abbr tdb 'task dev:bash'
abbr tdm 'task dev:migrate'
abbr tds 'task dev:seed'
abbr tdc 'task dev:console --'

# Docker / Podman
# alias docker podman

abbr p podman
abbr pc 'podman compose'

# Lazygit
abbr g lazygit
