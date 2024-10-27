{ pkgs ? import <nixpkgs> {} }:


let
  goVersion = "1.21.9"; # Specify your desired version

    sha256 = {
    "x86_64-darwin" = "1dgda1drij1c114xzv4hs44k7rx4x1vzghlxgii0h2rg641n6pbn";
    "aarch64-darwin" = 
  }.${stdenv.system};

  goSrc = pkgs.fetchFromGitHub {
    owner = "golang";
    repo = "go";
    rev = "go${goVersion}";
    sha256 = pkgs.lib.fakeSha256;
  };
  

in
pkgs.stdenv.mkDerivation {
  pname = "go";
  version = goVersion;

  src = goSrc;

  installPhase = ''
    mkdir -p $out/bin
    cp -r src/* $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "Go programming language";
    license = licenses.bsd3;
  };
}
