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
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };


  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux
    '';
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza --icons --classify";
      la = "eza --all --icons --classify";
      ll = "eza --long --all --git --icons";
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
