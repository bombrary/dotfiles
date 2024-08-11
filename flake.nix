{
  description = "NixOS and Home Manager Configuration";

  inputs = {
    nixos.url = github:NixOS/nixpkgs/nixos-24.05;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "NixOS-WSL";
      ref = "2311.5.3";
    };
    z-src = {
      url = github:rupa/z;
      flake = false;
    };
  };

  outputs = { self, nixos, nixpkgs, home-manager, nixos-wsl, z-src }: {
    nixosConfigurations = {
      minimal = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/minimal/configuration.nix
        ];
      };
      desktop = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
        ];
      };
      wsl = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/wsl/configuration.nix
        ];
        specialArgs = {
          inherit nixos-wsl;
        };
      };
    }; 

    homeConfigurations = {
      "bombrary@minimal" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./home/bombrary-minimal/home.nix
        ];
      };
      "bombrary@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./home/bombrary-desktop/home.nix
        ];
      };
      "bombrary@wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ./home/bombrary-wsl/home.nix
        ];
        extraSpecialArgs = {
          inherit z-src;
        };
      };
      "bombrary@macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ ./home/macos/home.nix ];
        extraSpecialArgs = {
          inherit z-src;
        };
      };
    };
    templates = {
      purescript.path = ./templates/purescript;
    };
  };
}
