{
  description = "NixOS and Home Manager Configuration";

  inputs = {
    nixos.url = github:NixOS/nixpkgs/nixos-25.05;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "NixOS-WSL";
      ref = "release-25.05";
    };
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixos, nixpkgs, home-manager, nixos-wsl, nixos-lima, ... }@inputs:
  {
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
      lima = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-lima.nixosModules.lima
          ./hosts/lima/nixos-lima-config.nix
        ];
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
      };
      "bombrary@macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ ./home/macos/home.nix ];
      };
      "bombrary@lima" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./home/lima/home.nix ];
      };
    };
    templates = {
      purescript.path = ./templates/purescript;
      go.path = ./templates/go;
      python-rye.path = ./templates/python-rye;
      rust.path = ./templates/rust;
    };
  };
}
