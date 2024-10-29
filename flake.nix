{
  description = "A collection of custom packages used for my system setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (import ./packages/go/overlay.nix)
        ];
        pkgs = import nixpkgs {
          inherit system;
          overlays = overlays;
        };
      in
      {
        packages = {
          go_1_21_9 = pkgs.go_1_21_9;
        };
      });

}
