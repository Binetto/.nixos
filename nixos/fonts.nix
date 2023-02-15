{ config, lib, pkgs, flake, ... }:

{

  environment.systemPackages = with pkgs; [
    faba-mono-icons
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;

    fonts = with pkgs; [
      font-awesome
      noto-fonts-emoji
      material-design-icons
      material-icons

        # Fonts
      (nerdfonts.override {
        fonts = [
          "Iosevka"
          "FiraCode"
          "JetBrainsMono"
          "Mononoki"
          "FantasqueSansMono"
        ];
      })
        # LaTeX
      lmodern
    ];

    fontconfig = {
      enable = true;
      includeUserConf = true;
      cache32Bit = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "JetBrainsMono Nerd Font Mono" ];
        sansSerif = [ "JetBrainsMono Nerd Font Mono" ];
        monospace = [
          #"FiraCode Nerd Font Mono"
          #"Iosevka Term"
          "FantasqueSansMono Nerd Font Mono"
          #"mononoki Nerd Font Mono"
        ];
      };
    };
  };
}
