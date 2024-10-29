let
  # Import Nixpkgs with your overlay applied
  nixpkgs = import <nixpkgs> {};

  # Apply the overlay
  pkgs = import <nixpkgs> { 
    overlays = [ 
      ( import ./packages/go/overlay.nix )
    ]; 
  };

  # create a custom collection 
  justusschock = pkgs.buildEnv {
    name = "justusschock";
    paths = [
      pkgs.go_1_21_9 
    ];
  };
in
{
  
  inherit justusschock;
}
