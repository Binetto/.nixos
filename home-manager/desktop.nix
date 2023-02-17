{ super, config, lib, pkgs, ... }:

{
  imports = [ ./librewolf.nix ];

  home.packages = with pkgs; [
    bitwarden
    (calibre.override { unrarSupport = true; })
    gammastep
    gimp
    hsetroot
    easyeffects
    inkscape
    libreoffice-fresh
    #FIXME:overlay- open-browser
    maim
    mupdf
    newsboat
    nsxiv
    pamixer
    peek
    pinta
    playerctl
    pulsemixer
    slop
    solaar
#    texlive.combined.scheme-full
    trackma-qt
    tremc
    udiskie
    #TODO unclutter-xfixes
    (unstable.discord.override { withOpenASAR = true; nss = nss_latest; })
    unstable.zoom-us
    #TODO xbanish # Hides the mouse when using the keyboard
        xcape
    xclip
    xdotool
    xdragon
    xorg.xev
#   xorg.xinit
    xorg.xmodmap
    xorg.xdpyinfo
    xorg.xkill
    zathura

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

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = false;
      documents = "$HOME/documents";
      download = "$HOME/downloads";
      pictures = "$HOME/pictures";
      videos = "$HOME/videos";
    };
      # Some applications like to overwrite this file, so let's just force it
    configFile."mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      defaultApplications =
      let
        browser = "librewolf.desktop";
      in {
        "application/pdf" = [ "pdf.desktop" ];
        "application/postscript" = [ "pdf.desktop" ];
        "application/rss+xml" = [ "rss.desktop" ];

        "image/png" = [ browser ];
        "image/jpeg" = [ "img.desktop" ];
        "image/gif" = [ "img.desktop" ];
        "inode/directory" = [ "file.desktop" ];

        "text/x-shellscript" = [ "text.desktop" ];
        "text/plain" = [ "text.desktop" ];
        "text/html" = [ "text.desktop" ];

        "video/x-matroska" = [ "video.desktop" ];

        "x-scheme-handler/magnet" = [ "torrent.desktop" ];
        "x-scheme-handler/mailto" = [ "mail.desktop" ];
        "x-scheme-handler/http" = [ browser ];
        "x-scheme-handler/https " = [ browser ];
        "x-scheme-handler/about" = [ browser ];
        "x-scheme-handler/unknown" = [ browser ];
      };
    };
  };  
}
