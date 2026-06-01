# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./Config_modules/Nvidia.nix
      ./Config_modules/Sddm.nix
      ./Config_modules/Fonts.nix
      ./Config_modules/Ollama.nix
       inputs.eden.nixosModules.default
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    pureref = pkgs.callPackage  ./Packages/pureref/default.nix {};
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # For the copy fail exploit
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
    lib.mkDefault pkgs.linuxPackages_6_18
  );

  # Enables flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "chelone"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

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
  # You can disable this if you're only using the Wayland session.
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.justaturtle = {
    isNormalUser = true;
    description = "Orhaan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  users.users.killer = {
    isNormalUser = true;
    description = "Erdogan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Enables flatpak support
  services.flatpak = {
    enable = true;
    packages = [
      "it.mijorus.gearlever"
      "org.nickvision.tubeconverter"
    ];
  };
  # Install firefox.
  programs.firefox.enable = true;

  # Installs steam
  programs.steam = {
    enable = true;
    # Related to the piracy part in Home_modules/Apps/software.nix
    package = pkgs.steam.override {
      extraEnv = {
        LD_AUDIT = "${inputs.sls-steam.packages.${pkgs.system}.sls-steam}/SLSsteam.so";
      };
    };
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enables bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Kde connect
  programs.kdeconnect.enable = true;

  # Eden emulator
  programs.eden = {
     enable = true;
  };

  # Polkit for sway
  security.polkit.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  # Podman for distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Waydroid
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  environment.systemPackages = with pkgs; [
     zed-editor
     vscodium
     wezterm
     distrobox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # So electron apps play nice with Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Optimizes space
  #
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.loader.systemd-boot.configurationLimit = 10;

}
