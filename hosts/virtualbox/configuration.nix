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

  # dwm
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.dwm-status.enable = true;

  # windows key as mod key
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = [ ./dwm.patch ];
  };

  # Packages
  users.users.lloyd.packages = with pkgs; [
    # User packages
  ];

  environment.systemPackages = with pkgs; [
    dmenu
    st
  ];
}
