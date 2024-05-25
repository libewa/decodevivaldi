{
  description = "Add Vivaldi's Spring to the Decode Unicode movie";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.defaultPackage.x86_64-linux}/bin/makevideo.sh";
    };

    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "makevideo";
      src = ./.;
      installPhase = ''
        mkdir -p $out/bin
        cp makevideo.sh $out/bin/
      '';
    };
  };
}