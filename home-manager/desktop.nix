{ super, config, lib, pkgs, ... }:

{

  options.gaming.enable = pkgs.lib.mkEnableOption "gaming Packages" // { default = false; };

  modules.programs.mpv.desktopConfig = true;

  home.packages = with pkgs; [
    (calibre.override { unrarSupport = true; })
    gimp
    easyeffects
    inkscape
    #FIXME:overlay- open-browser
    pinta
    solaar
#    texlive.combined.scheme-full
    (unstable.discord.override { withOpenASAR = true; nss = nss_latest; })
  ];

  config = lib.mkIf config.gaming.enable {
    home.packages = with pkgs; [
        prismlauncher
        grapejuice
        mangohud # afterburner like
        #runescape runelite
        #zeroad
        #yuzu-mainline
        #retroarchFull
          # retroarch with specific cores
        (retroarch.override {
          cores = [
            libretro.mgba
            libretro.snes9x
            libretro.mesen
            libretro.parallel-n64
            libretro.dolphin
            libretro.pcsx2
            libretro.ppsspp
          ];
        })
        #inputs.nix-gaming.packages.${pkgs.system}.osu-stable
        #inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
  };

  xdg = {
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
