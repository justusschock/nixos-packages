# Overlay to make go 1.21.9 available
# This depends on the patches list from nixpkgs 24.11

self: super: {
  go_1_23_4 = super.go.overrideAttrs (old: {
    version = "1.23.4";
    src = super.fetchurl {
      url = "https://go.dev/dl/go1.23.4.src.tar.gz";
      sha256 = "sha256-rTRaxCHpCBQpOpaZzKGd1SOCUcP2h5gLvK4oSVsmNTE=";
    };
  });
}
