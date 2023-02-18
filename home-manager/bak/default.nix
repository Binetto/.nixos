{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  imports = [
#    ./packages.nix

    ./cli/git
    #./cli/neovim
    ./cli/tmux
    ./cli/xdg
    ./cli/xresources
    ./cli/zsh

#    ./programs/discocss
    ./programs/discord
#    ./programs/dmenu
    ./programs/gtk
#    ./programs/mutt
#    ./programs/nnn
    ./programs/powercord
#    ./programs/slstatus
#    ./programs/terminal
#    ./programs/zathura

#    ./services/dunst
#    ./services/picom
#    ./services/flameshot
    ./services/ssh
#    ./services/sxhkd
#    ./services/syncthing
#    ./services/udiskie
  ];


}
