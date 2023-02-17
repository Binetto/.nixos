{ pkgs, config, lib, ... }:
{
  imports = [
    #./boot
    #./laptop
    ./services
    ./desktop
    ./server
    #./gaming
  ];
}
