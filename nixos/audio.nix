{ config, lib, flake, pkgs, ... }:

{
  options.nixos.audio.enable = lib.mkEnableOption "audio config" // { default = true; };

  config = lib.mkIf config.nixos.audio.enable {

      # This allows PipeWire to run with realtime privileges (i.e: less cracks)
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
        # https://github.com/fufexan/nix-gaming/blob/master/modules/pipewireLowLatency.nix
      lowLatency = {
          enable = true;
          quantum = 64;
          rate = 48000;
      };
    };

  };
}
