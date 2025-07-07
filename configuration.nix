# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Temp: to run puppeteer
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    atk
    atkmm
    cairo
    cups
    dbus
    expat
    fontconfig
    gcc
    glib
    gtk3
    libgbm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    # wifi.powersave = false; # This should™ help against NetworkManager crashing after sleep mode
  };

  # Bluetooth settings
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lloyd = {
    isNormalUser = true;
    description = "LLoyd";
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Uncategorized Apps
      anki-bin
      gimp3
      # newsflash
      # nyxt                # this looking cool
      obsidian
      qbittorrent
      rclone
      ungoogled-chromium

      # Socials
      teams-for-linux   # Microsoft Teams
      teamspeak3        # Teamspeak
      vesktop           # Discord
      # telegram-desktop  # Telegram
      # zapzap            # Whatsapp

      # Spotify + Gnome extension
      gnomeExtensions.spotify-controls
      spotify

      # Video player
      mpv
      streamlink     # twitch.tv support
      yt-dlp         # YouTube support

      # Office suite
      libreoffice-qt6-fresh
      # hunspell
      # hunspellDicts.en_US
      # hunspellDicts.it_IT

      # Development?
      android-studio
      bruno
      jetbrains.idea-ultimate
      maven
      nerd-fonts.jetbrains-mono
      nodejs_22
      podman-desktop
      vscode
      gcc

      # Emacs
      djview                   # Viewing djvu files
      djvulibre                #
      emacs
      emacs-lsp-booster
      emacsPackages.pdf-tools

      # Language servers
      angular-language-server  # Angular LSP
      jdt-language-server      # Eclipse JDT LSP
    ];
  };

  # Firefox.
  programs.firefox.enable = true;

  # Zoom
  programs.zoom-us.enable = true;

  # ZSH
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  # Zoxide
  programs.zoxide.enable = true;

  # Neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  # Emacs
  services.emacs.install = true;
  services.emacs.enable = true;

  # Tmux
  programs.tmux = {
    enable = true;
    newSession = true; # Create a new session if none to attach to
    keyMode = "emacs";
    clock24 = true;
  };

  # Git
  programs.git.enable = true;  

  # Lazygit
  programs.lazygit.enable = true;

  # Java Development
  programs.java.enable = true;

  # Virtual machines
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Containers
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
    };
  };
  
  # Packages
  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Extra Gnome goodies
    gnomeExtensions.appindicator
    gnomeExtensions.freon

    # Utils I want to have on my root :)
    fzf
    ghostty
    ripgrep

    # Node packages
    nodePackages."@angular/cli"
    nodePackages."@astrojs/language-server"
  ];

  # Exclude packages from Gnome
  environment.gnome.excludePackages = (with pkgs; [
    decibels
    epiphany
    evince
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-text-editor
    gnome-tour
    simple-scan
    totem
    yelp
  ]);

  # Jackett
  # services.jackett.enable = true;
  # services.flaresolverr.enable = true;
  
  # Environment Variables
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Fingerprint support
  services.fprintd.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 631 ];
    # allowedUDPPorts = [ ... ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
