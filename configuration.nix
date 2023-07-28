# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the GRUB boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.timeout = 30;

  networking.hostName = "bombrary-pc"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # networking.wireless.networks = {
  #   "Buffalo-G-F5C8" = {
  #     psk = "kuxu4s634advx";
  #   };
  # };
  # networking.interfaces.wlp42s0f3u4= {
  #   useDHCP=false;
  #   ipv4.addresses= [{ 
  #       address = "192.168.1.2";
  #       prefixLength = 24;
  #   }];
  # };
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "192.168.1.1" ];


  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "jp106";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  # console.keyMap = "jp106";
  console.keyMap = "us";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    layout = "us";
    
    # XMonad setting
    # displayManager.lightdm.enable = false;
    # windowManager.xmonad = {
    #   enable = false;
    #   enableContribAndExtras = true;
    #   extraPackages = haskellPackages : with pkgs; [
    #       	      haskellPackages.xmobar
    #                   ];
    # };
    # desktopManager.runXdgAutostartIfNone = true;

    # GNOME setting
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
      runXdgAutostartIfNone = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    ipaexfont
    myrica
  ];

  fonts.fontconfig = {
     enable = true;

     defaultFonts = {
       sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
       serif = [ "Noto Serif JP" "DejaVu Serif" ];
     };

     subpixel = { lcdfilter = "light"; };
  };
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bombrary = {
    isNormalUser = true;
    home = "/home/bombrary";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$1fgsXTNB7PZHpRx/$0cYOtcTxjyjrtI3WMs0wLsEV0PanTKa7mJvHQwFCPucmwQfv19qOzIqgN/R.A6S.AZGAL9nd7mY5rZyPTS91w.";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    alacritty
    xclip
    docker-compose
    cudatoolkit
    dmenu
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  virtualisation = {
    docker.enable = true;
  };

  nix.settings.sandbox = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

