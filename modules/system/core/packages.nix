{ pkgs, ... }: {

    # install basic packages
  environment.systemPackages = with pkgs; [
        # sys
      # TODO: pwgen cryptsetup
      python3Full
      perl
      bat # cat clone with syntax highlighting
      cron
      git git-crypt
      gcc
      wget
      curl
      gnumake
      binutils
      killall
      yt-dlp
      htop
      fzf
      jq
        # pass
#      pinentry
#      pinentry-qt
#      pass

        # monitoring
      lm_sensors

        # file system
      atool # archive tool
      exa
      rsync # replace scp
    ];

}
