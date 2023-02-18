{ config, flake, lib, ... }: {

  home.stateVersion = "22.05";
  imports = [
#    ../hosts/${config.networking.hostName}/user.nix
    ./cli.nix
    ./desktop.nix
#    ./git.nix
    ./lf
#    ./mpv
    ./neovim.nix
    ./newsboat.nix
     ./qutebrowser
#    ./ssh.nix
#    ./st.nix
#    ./tmux.nix
#    ./zsh.nix
  ];

}
