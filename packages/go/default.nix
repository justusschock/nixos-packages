{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  defaultGoVersion = "1.21.9"; # Specify your desired version
  defaultGoSha256 = "sha256-ET3WpMO0JssKER3l0Q2XfISjdCp2oQYnnzo77CZiC9Q=";

  # Use fetchFromGitHub with a placeholder hash
  goSrc = pkgs.fetchFromGitHub {
    owner = "golang";
    repo = "go";
    rev = "go${defaultGoVersion}";
    sha256 = defaultGoSha256;
  };

in
pkgs.stdenv.mkDerivation {
  pname = "go";
  version = defaultGoVersion;

  src = goSrc;

  # Phases to handle the build and installation
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r src/* $out/bin/  # Adjust this if the structure differs
  '';

  # Optionally, you can add a build command if needed
  buildCommand = ''
    echo "Building Go version ${defaultGoVersion}"
  '';

  meta = with pkgs.lib; {
    description = "Go programming language";
    license = licenses.bsd3;
  };
}
