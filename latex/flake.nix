{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, latex }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        dev-packages = with pkgs; [
          texlive.combined.scheme-medium
          texlab
          zathura
          wmctrl
          which
          python39Packages.pygments
        ];

      in
      rec {
        devShell = pkgs.mkShell {
          name = "texlive";
          buildInputs = [ dev-packages ];
        };

        packages.document = latex.lib.latexmk {
          src = ./.;
          shellEscape = true;
          minted = true;
          name = "document.pdf";
        };

        defaultPackage = packages.document;
      }
    );
}
