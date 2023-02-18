{ lib, ... }: {

  imports = [
    ./minimal.nix
    ./lf
    ./mpv
    ./newsboat.nix
    ./pc.nix
    ./qutebrowser
  ];

  modules.programs = {
    mpv.laptopConfig.enable = true;
  };

}
