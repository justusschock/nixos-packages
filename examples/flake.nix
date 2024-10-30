{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";  # Use your desired Nixpkgs channel
    flake-utils.url = "github:numtide/flake-utils";
    justusschock.url = "github:justusschock/nixos-packages";
  };

  outputs = { self, nixpkgs, flake-utils, justusschock, ... }: 
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ ];
      };
      go_1_21_9 = justusschock.packages.${system}.go_1_21_9;

      allPackages = pkgs.buildEnv {
        name = "all-packages";
        paths = pkgs.lib.attrValues (justusschock.packages.${system});
      };
    in
    {
      packages = {
        inherit go_1_21_9; 
      };
      
      defaultPackage = allPackages;

      devShells = {
        default = pkgs.mkShell {
          buildInputs = [ justusschock.go_1_21_9 ];  # Example usage
        };
      };
    }
  );
}
