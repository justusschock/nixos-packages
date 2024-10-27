{ pkgs ? import <nixpkgs> {} }:

let
  goVersion = "1.21.9"; # Specify your desired version
  goSrc = pkgs.fetchFromGitHub {
    owner = "golang";
    repo = "go";
    rev = "go${goVersion}.src";
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
