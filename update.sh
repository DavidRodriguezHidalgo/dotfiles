#!/bin/zsh

chezmoi update

rm -rf ~/.config/nvim/lua/user
git clone https://github.com/DavidRodriguezHidalgo/astro_config ~/.config/nvim/lua/user
