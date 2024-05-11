{pkgs, ...}: {
  home = rec {
    username = "bombrary";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  home.packages = with pkgs; [
    ripgrep
    neovim
    eza
    bat
    git
    deno
    zig
    ccls
  ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux
    '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons --classify";
      la = "eza --all --icons --classify";
      ll = "eza --long --all --git --icons";
      cat = "bat";
    };
  };

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

  programs.home-manager.enable = true;
}
