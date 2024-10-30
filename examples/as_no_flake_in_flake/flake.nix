{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";  # Use your desired Nixpkgs channel
    flake-utils.url = "github:numtide/flake-utils";
    justusschock.url = "github:justusschock/nixos-packages";
    justusschock.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, justusschock, ... }: 
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ ];
      };

      # Import default.nix from the fetched repo
      justusschock-packages = import justusschock { inherit pkgs; };
    in
    {
      packages = {
        # If your default.nix returns an attribute set of packages
        go_1_21_9 = justusschock-packages.go_1_21_9;
      };

      devShells = {
        default = pkgs.mkShell {
          buildInputs = [ justusschock-packages.go_1_21_9 ];  # Example usage
        };
      };
    }
  );
}