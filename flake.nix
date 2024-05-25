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
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        bash
        ffmpeg
        yt-dlp
      ];

      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        makeWrapper
      ];
      installPhase = ''
        mkdir -p $out/bin
        cp makevideo.sh $out/bin/
        wrapProgram $out/bin/makevideo.sh \
          --prefix PATH : "${nixpkgs.legacyPackages.x86_64-linux.lib.makeBinPath [ nixpkgs.legacyPackages.x86_64-linux.ffmpeg nixpkgs.legacyPackages.x86_64-linux.yt-dlp]}"
      '';
    };
  };
}
