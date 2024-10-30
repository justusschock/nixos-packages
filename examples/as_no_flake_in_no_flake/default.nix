{ pkgs ? import <nixpkgs> {} }:

let
  # Import the external repository
  justusschock = import (pkgs.fetchFromGitHub {
    owner = "justusschock";
    repo = "nixos-packages";
    sha256 = pkgs.lib.fakeSha256;        # Provide the correct sha256 hash of the source
  }) {};

  # Use the imported package directly
  # In this case, `justusschock` refers to the `buildEnv` environment created in the external repo's `default.nix`
  myEnv = justusschock.go_1_21_9;
in
{
  inherit myEnv;
}