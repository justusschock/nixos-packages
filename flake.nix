{
  description = "My custom nix packages collection";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # You can specify a different branch or tag

  outputs = { self, nixpkgs }: let
    # Define a function to build packages for a given system
    mkPackages = system: {
      go = nixpkgs.legacyPackages.${system}.callPackage ./packages/go/default.nix {};
    };
  in {
    # Define outputs for different architectures
    packages.x86_64-linux = mkPackages "x86_64-linux";
    packages.x86_64-darwin = mkPackages "x86_64-darwin";
    packages.aarch64-darwin = mkPackages "aarch64-darwin"; # For M1 Mac

    # Optional: Create a development shell for each system
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
