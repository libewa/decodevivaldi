{
  description = "Add Vivaldi's Spring to the Decode Unicode movie";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flakeutils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flakeutils }:
    flakeutils.lib.eachSystem ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" "i686-linux"] (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        apps.default = {
          type = "app";
          program = "${self.defaultPackage.${system}}/bin/makevideo.sh";
        };

        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "makevideo";
          src = ./.;
          buildInputs = with pkgs; [
            bash
            ffmpeg
            yt-dlp
          ];

          nativeBuildInputs = with pkgs; [
            makeWrapper
          ];
          installPhase = ''
            mkdir -p $out/bin
            cp makevideo.sh $out/bin/
            wrapProgram $out/bin/makevideo.sh \
              --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.ffmpeg pkgs.yt-dlp]}"
          '';
        };
      }
    );
}
