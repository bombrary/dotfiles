{ config, pkgs, ... }:

{
  home.username = "bombrary";
  home.homeDirectory = "/home/bombrary";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    tmux
    ripgrep
    eza
    bat
    fd
    zig
    deno
    rye
    nodePackages.pyright
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

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
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
