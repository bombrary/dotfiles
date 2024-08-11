{
  description = "purescript project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";
  };

  outputs = { nixpkgs, flake-utils, easy-purescript-nix, ... }:
  flake-utils.lib.eachDefaultSystem
  (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      easy-ps = easy-purescript-nix.packages.${system};
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        name = "purescript-shell";
        buildInputs = [
          easy-ps.purs-0_15_8
          easy-ps.spago
        ];
      };
   }
  );
}
