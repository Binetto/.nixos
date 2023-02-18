{ pkgs, ... }: {

  imports = [
    ./librewolf.nix
    ./newsboat.nix
    #./dwm
  ];

  home.packages = with pkgs; [
    bitwarden
    gammastep
    hsetroot
    libreoffice-fresh
    stable.maim
    mupdf
    newsboat
    nsxiv
    pamixer
    playerctl
    pulsemixer
    stable.slop
    trackma-qt
    tremc
    udiskie
    xdotool
    xdragon
    xorg.xev
#   xorg.xinit
    xorg.xmodmap
    xorg.xdpyinfo
    xorg.xkill
    zathura
    #TODO unclutter-xfixes
    #TODO xbanish # Hides the mouse when using the keyboard
      # emails
#   mutt-wizard
#   neomutt
#   isync
#   msmtp
#   lynx
#   notmuch
#   abook
#   urlview
#   mpop
#    rcon
  ];

  programs.zsh.shellAliases = {
    copy = "${pkgs.xclip}/bin/xclip -selection c";
    paste = "${pkgs.xclip}/bin/xclip -selection c -o";
  };

  services.udiskie = {
    enable = true;
    tray = "never";
  };

}
