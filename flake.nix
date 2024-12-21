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
          (import ./packages/go/1.21.9/overlay.nix)
          (import ./packages/go/1.23.4/overlay.nix)
        ];
        pkgs = import nixpkgs {
          inherit system;
          overlays = overlays;
        };
      in
      {
        packages = {
          go_1_21_9 = pkgs.go_1_21_9;
          go_1_23_4 = pkgs.go_1_23_4;
        };
      });

}
