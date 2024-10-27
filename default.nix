{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) stdenv;

  # Define the Go package
  go = import ./packages/go/default.nix {
    inherit pkgs;
  };

in
pkgs.buildEnv {
  name = "justusschock-packages";
  paths = [ go ];
}
