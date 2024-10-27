{
  description = "My custom Nix package collection for multiple architectures";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Adjust as needed

  outputs = { self, nixpkgs }: let
    # Define a function to build packages for a given system
    mkPackages = system: {
      go = nixpkgs.legacyPackages.${system}.callPackage ./packages/go/default.nix {
        inherit (nixpkgs.legacyPackages.${system}) pkgs;
      };
    };
  in {
    # Define outputs for different architectures
    packages.x86_64-linux = mkPackages "x86_64-linux";
    packages.x86_64-darwin = mkPackages "x86_64-darwin";
    packages.aarch64-darwin = mkPackages "aarch64-darwin";

    # Optional: Create development shells for each system
    devShell.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [ self.packages.x86_64-linux.go ];
    };

    devShell.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.mkShell {
      buildInputs = [ self.packages.x86_64-darwin.go ];
    };

    devShell.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
      buildInputs = [ self.packages.aarch64-darwin.go ];
    };
  };
}
