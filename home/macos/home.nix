{ config, pkgs, lib, ... }:

{
  home.username = "bombrary";
  home.homeDirectory = "/Users/bombrary";

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    obsidian
    alacritty
  ];

  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    userName = "bombrary";
    userEmail = "bombra108@gmail.com";
    extraConfig = {
      credential.helper = "store";
    };
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


  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
