{ flake, pkgs, lib, config, ... }:

{
  
  imports = [ ./minecraft-server ];

  options.gaming.enable = pkgs.lib.mkDefaultOption "Gaming config";

  config = lib.mkIf config.gaming.enable {

    environment = {
      systemPackages = with pkgs; [
        steam
        piper # GTK frontend for ratbagd mouse config daemon
        #(lutris.override { lutris-unwrapped = lutris-unwrapped.override {
          #wine = inputs.nix-gaming.packages.${pkgs.system}.wine-tkg;
        #};})
        unstable.lutris
        jdk # Minecraft Java
        steamPackages.steamcmd
        steam-tui
          # League of Legends
        vulkan-tools
        openssl
        gnome.zenity
        amdvlk # Vulkan drivers (probably already installed)
        dxvk
        wineWowPackages.staging
        winetricks
      ];
    };
  
    /* --Gamemode-- */
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  
    /* --Steam-- */
    programs.steam = { enable = true; };
    hardware.steam-hardware.enable = true;
    home-manager.sharedModules =
      let
        version = "GE-Proton7-49";
        proton-ge = fetchTarball {
          url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
          sha256 = "sha256:1wwxh0yk78wprfi1h9n7jf072699vj631dl928n10d61p3r90x82";
        };
      in [
        ({ config, lib, pkgs, ... }: {
          home.activation.proton-ge-custom = ''
            if [ ! -d "$HOME/.steam/root/compatibilitytools.d/${version}" ]; then
              cp -rsv ${proton-ge} "$HOME/.steam/root/compatibilitytools.d/${version}"
            fi
          '';
        })
      ];
  
    /* ---League of Legends--- */
    boot.kernel.sysctl = { "abi.vsyscall32" = 0; }; # anti-cheat requirement
    environment.sessionVariables = { QT_X11_NO_MITSHM = "1"; };
  
      # Driver for Xbox One/Series S/Series X controllers
    hardware.xpadneo.enable = true;
  
      # Enable ratbagd (i.e.: piper) for Logitech devices
    services.ratbagd.enable = true;
  
    nix.settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

}
