{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../common/configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  # Virtualbox guest CD
  virtualisation.virtualbox.guest.enable = true;
}
