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
    git
    deno
    zig
    tmux
  ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons --classify";
      la = "eza --all --icons --classify";
      ll = "eza --long --all --git --icons";
    };
  };
  programs.home-manager.enable = true;
}
