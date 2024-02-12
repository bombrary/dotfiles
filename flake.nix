{
  description = "NixOS Configuration";

  inputs = {
    nixos.url = github:NixOS/nixpkgs/nixos-23.11;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "path:./dotfiles";
      flake = false;
    };
  }; 

  outputs = { self, nixos, home-manager, nixpkgs, dotfiles, ... }: {
    nixosConfigurations = {
      minimal = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./os-configs/minimal/configuration.nix ];
      };
    };

    homeConfigurations = {
      bombrary = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {
          inherit dotfiles;
        };
        modules = [
          ./home-configs/bombrary/home.nix
        ];
      };
    };
  };
}
