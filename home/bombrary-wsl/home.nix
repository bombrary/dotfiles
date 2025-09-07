{pkgs, z-src, ...}: {
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
    ghq
    peco
    textlint
    uv
    pyright
    chromedriver
    chromium
    ncurses
    jq
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };


  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
    };

    initContent = (builtins.readFile ../../config/peco_settings.zsh) + ''
    . ${z-src}/z.sh

    export PROMPT="%F{10}%n@%m%f:%F{12}%~%f%# "
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
      ];
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
    "z" = {
      source = "${z-src}/z.sh";
      target = "z/z.sh";
    };
  };

  programs.home-manager.enable = true;
}
