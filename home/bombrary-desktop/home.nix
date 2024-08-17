{ config, pkgs, z-src, ... }:
{
  home = rec {
    username = "bombrary";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
    file = {
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  # command line tools
    bat
    bottom
    du-dust
    duf
    eza
    fd
    fzf
    imagemagick
    jq
    ripgrep
    ffmpeg-full
    unzip
    zip
    maim
    xclip
    xdotool
    peco

  # compilers and interperters
    deno
    zig

  # gui tools
    wireshark
    gimp
    reaper
    yabridge
    yabridgectl
    xfce.thunar
    google-chrome
    sxiv
    obsidian
    vlc
    wineWowPackages.full
    winetricks
    zoom-us
    brave
    slack
    krita

  # DAW plugin
    carla
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userName = "bombrary";
    userEmail = "bombra108@gmail.com";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".tmux.conf" = {
      source = ../../config/tmux/.tmux.conf;
      target = ".tmux.conf";
    };
    "init.lua" = {
      source = ../../config/nvim/init.lua;
      target = ".config/nvim/init.lua";
    };
    "lua" = {
      source = ../../config/nvim/lua;
      target = ".config/nvim/lua";
    };
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
    };
    initExtra = (builtins.readFile ../../config/peco_settings.zsh) + ''
    . ${z-src}/z.sh
    '';

    prezto = {
      enable = true;
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "git"
        "syntax-highlighting"
        "prompt"
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      status = {
        disabled = false;
      };
      time = {
        disabled = false;
        utc_time_offset = "+9";
      };
    };
  };

  programs.go = {
    enable = true;
  };
}
