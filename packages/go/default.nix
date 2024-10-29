{ pkgs ? import <nixpkgs> {} }:

let
  goVersion = "1.21.9"; # Specify your desired version

  # Use fetchFromGitHub with a placeholder hash
  goSrc = pkgs.fetchFromGitHub {
    owner = "golang";
    repo = "go";
    rev = "go${goVersion}";
    sha256 = lib.fakeSha256;  # Use fakeSha256 to get the actual hash
  };

in
pkgs.stdenv.mkDerivation {
  pname = "go";
  version = goVersion;

  src = goSrc;

  # Phases to handle the build and installation
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r src/* $out/bin/  # Adjust this if the structure differs
  '';

  # Optionally, you can add a build command if needed
  buildCommand = ''
    echo "Building Go version ${goVersion}"
  '';

  meta = with pkgs.lib; {
    description = "Go programming language";
    license = licenses.bsd3;
  };
}
