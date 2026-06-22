{ config, pkgs, ... }:

{
  imports =
    [
      ../../common/configuration.nix
      ./hardware-configuration.nix
    ];
}
