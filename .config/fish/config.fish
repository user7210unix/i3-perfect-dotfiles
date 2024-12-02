# Begin ~/.config/fish/config.fish

# Set up prompt
set -g fish_color_normal white
set -g fish_color_command green
set -g fish_color_redirection yellow
set -g fish_color_error red
set -g fish_color_comment cyan
set -g fish_color_command_substitution magenta
set -g fish_color_operator yellow
set -g fish_color_argument blue

# Set custom prompt format (similar to PS1 in bash)
function fish_prompt
    set_color $fish_color_command
    echo -n (date +%H:%M) ' '
    set_color $fish_color_normal
    echo -n (prompt_pwd) ' > '
end

# Aliases (similar to bash aliases)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fetch='./env-info.sh'
alias c='clear'
alias install='sudo nala install -y'
alias reboot='sudo reboot now'
alias off='sudo poweroff now'
alias update='sudo nala update -y && sudo nala upgrade -y'
alias l='ls -la'
alias clone 'git clone --depth 1'
alias merge 'xrdb ~/.Xresources'

# Fish plugins installation via Oh My Fish
# Install useful plugins
set -g fish_greeting '' 

clear

neofetch

# End ~/.config/fish/config.fish
