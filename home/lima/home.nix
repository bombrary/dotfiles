{ config, pkgs, ... }:

{
  home.username = "bombrary";
  home.homeDirectory = "/home/bombrary.guest";

  home.packages = [
    pkgs.hello
  ];
  # Git config will typically be placed in ~/.config/git/config
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;  # Minimal Git without Perl or Python
    settings = {
      alias = {
        ci = "commit";
        co = "checkout";
        st = "status";
      };
      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "26.11";
}
