{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./cli/git
    ./cli/neovim
    ./cli/tmux
    ./cli/xdg
    ./cli/xresources
    ./cli/zsh

    ./programs/chromium
#    ./programs/discocss
    ./programs/dmenu
    ./programs/gtk
    ./programs/librewolf
    ./programs/lf
    ./programs/mpv
#    ./programs/mutt
    ./programs/newsboat
#    ./programs/nnn
    ./programs/powercord
    ./programs/qutebrowser
    ./programs/slstatus
#    ./programs/zathura

    ./services/dunst
    ./services/picom
    ./services/flameshot
    ./services/sxhkd
#    ./services/syncthing
#    ./services/udiskie
  ];


}
