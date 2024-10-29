let
  # Import Nixpkgs with your overlay applied
  nixpkgs = import <nixpkgs> {};
  myOverlay = import ./packages/go/overlay.nix;

  # Apply the overlay
  pkgs = import <nixpkgs> { 
    overlays = [ 
      ( import ./packages/go/overlay.nix )
    ]; 
  };

  # create a custom collection 
  justusschock-packages = pkgs.buildEnv {
    name = "justusschock-packages";
    paths = [
      pkgs.go_1_21_9 
    ];
  };
in
{
  
  inherit justusschock-packages;
}
