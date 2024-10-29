{
  description = "My custom Nix package collection for multiple architectures";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Apply the overlay to nixpkgs
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ( import ./packages/go/overlay.nix )
          ];
        };
      in
      {
        packages = {
          go_1_21_9 = pkgs.go_1_21_9;
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ pkgs.go_1_21_9 ];
          };
        };
      }
    );
}
