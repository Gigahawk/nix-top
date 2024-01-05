{
  description = "Flake for nix-top";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          nix-top = pkgs.callPackage ./default.nix { inherit pkgs; };
          default = self.packages.${system}.nix-top;
        };
      });
}
