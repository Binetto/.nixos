{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
      atool # archive tool
    bat
    bc
    bind
    binutils
    coreutils
    cron
    #TODO cryptsetup
    curl
    daemonize # runs a command as a Unix daemon
    diffutils
    dos2unix
    dua
    each
    exa
    file
    findutils
    fzf
    gcal
    gcc
    gnumake
    gnused
    gotop
    htop
    inetutils
    ix
    jo
    jq
    killall
    lsof
    mediainfo
    moreutils
    ncdu
    netcat-gnu
    nix-tree
    openssl
    ouch
    p7zip
    page
#   pinentry pinentry-qt pass
    pipe-rename
    perl
    pv
    pwgen
    python3
    rar
    ripgrep
    rlwrap
    rsync # replace scp
    tealdeer
    tig
    tokei
    unzip
    wget
    yt-dlp
    zip
  ];

  programs.zsh.shellAliases = {
    # For muscle memory...
    #ncdu = "${pkgs.dua}/bin/dua interactive";
  };
}
