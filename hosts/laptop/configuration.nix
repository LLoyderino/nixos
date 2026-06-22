{ config, pkgs, ... }:

{
  imports =
    [
      ../../common/configuration.nix
      ./hardware-configuration.nix
    ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Fingerprint support
  services.fprintd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      # HP Printer drivers
      hplip
      hplipWithPlugin
    ];
    extraConf = ''
      ErrorPolicy retry-job
    '';
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

  # Scanner
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan
      pkgs.hplipWithPlugin
    ];
  };

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 631 ];
    # allowedUDPPorts = [ ... ];
  };
}
