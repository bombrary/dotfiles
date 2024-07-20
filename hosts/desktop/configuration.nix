# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/FA59-1A3F";
    fsType = "exfat";
    options = [
      "defaults"
      "nofail"
      "uid=1000"
      "gid=100"
    ];
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.timeout = 30;

  networking.hostName = "bombrary-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.nameservers = ["94.140.14.14" "94.140.15.15"];
  environment.etc = {
    "resolv.conf".text = ''
        nameserver 94.140.14.14
        nameserver 94.140.15.15
        nameserver 192.168.11.1
        options edns0
    '';
  };

  fileSystems."/mnt/nfs" = {
    device = "192.168.11.8:/home/nfs";
    fsType = "nfs";
  };


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

   # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the i3wm Environment.
  services.displayManager = {
    defaultSession = "none+i3";
  };
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        polybarFull
        rofi
        nitrogen
      ];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  services.xserver.wacom.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # enableMPD
  services.mpd = {
    enable = true;
  };

  services.transmission = { 
    enable = true; #Enable transmission daemon
    openRPCPort = true; #Open firewall for RPC
    settings = { #Override default settings
      rpc-bind-address = "0.0.0.0"; #Bind to own IP
      rpc-whitelist = "127.0.0.1,10.0.0.1"; #Whitelist your remote machine (10.0.0.1 in this example)
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bombrary = {
    isNormalUser = true;
    description = "Riku Yamamoto";
    extraGroups = [ "networkmanager" "wheel" "docker" "jackautio" "wireshark" ];
    packages = with pkgs; [
      qjackctl
      alacritty
      chromium
      zoom
      discord
    ];
    shell = pkgs.fish;
  };

  programs = {
    git = {
      enable = true;
    };
    fish = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    mtr =  {
      enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    killall
    vim
    xclip

    qemu
    transmission-gtk
    chromedriver
  ];

  services.envfs.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Font Setting.
   fonts = {
     packages = with pkgs; [
       noto-fonts-cjk-serif
       noto-fonts-cjk-sans
       noto-fonts-emoji
       nerdfonts
       migu
     ];
     fontDir.enable = true;
     fontconfig = {
       defaultFonts = {
         serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
         sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
         monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
         emoji = ["Noto Color Emoji"];
       };
       localConf = ''
         <?xml version="1.0"?>
         <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
         <fontconfig>
           <description>Change default fonts for Steam client</description>
           <match>
             <test name="prgname">
               <string>steamwebhelper</string>
             </test>
             <test name="family" qual="any">
               <string>sans-serif</string>
             </test>
             <edit mode="prepend" name="family">
               <string>Migu 1P</string>
             </edit>
           </match>
         </fontconfig>
       '';
     };
   };

  # Enable docker.
  virtualisation = {
    docker.enable = true;
  };

  # Enable Nix flake.
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.nix-ld.enable = true;

  # Install Steam
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true;
     dedicatedServer.openFirewall = true;
   };
}
