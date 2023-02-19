{ pkgs, config, lib, ... }:
{
  imports = [
    ./services
    ./server
  ];
}
