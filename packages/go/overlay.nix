# Overlay to make go 1.21.9 available
# This depends on the patches list from nixpkgs 24.05

self: super: {
  go_1_21_9 = super.go.overrideAttrs (old: {
    version = "1.21.9";
    src = super.fetchurl {
      url = "https://go.dev/dl/go1.21.9.src.tar.gz";
      sha256 = "sha256-WPDFztRaABK84v96nfA+Eoq8yIGOur5QJ7uSuv4g5CE=";
    };

    # needs to drop go_no_vendor_checks-1.22.patch
    patches = super.lib.lists.init old.patches;
  });
}
