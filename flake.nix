{
  description = "Dev environment for jinmoncom 2025 paper 29";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs allSystems (system:
          f {
            pkgs = import nixpkgs { inherit system; };
          });

    in {
      devShells = forAllSystems ({ pkgs }: {
        default = let
          tex = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-basic
              latexmk
              # Japanese support packages
              platex
              ptex
              pbibtex-base
              # mendex for Japanese index
              makeindex
              upmendex
              # Fonts and maps
              ptex-fonts
              ptex-fontmaps
              japanese-otf
              collection-langjapanese
              pxchfon           # Japanese font support
              metafont          # Metafont support
              pxjahyper         # hyperref support for Japanese
              bxjatoucs         # Unicode support for Japanese
              # dvi to pdf converter
              dvipdfmx
              # Commonly used packages
              amsmath
              amscls
              tools
              graphics
              booktabs
              siunitx
              pgf
              geometry
              cleveref
              url
              hyperref
              ulem
              svg
              transparent
              catchfile;         # for \input commands
          };
        in
          pkgs.mkShell {
            packages = [ tex ];
            
            shellHook = ''
              echo ""
              echo "Available commands:"
              echo "  platex draft.tex           # compile with pLaTeX"
              echo "  dvipdfmx draft.dvi         # convert DVI to PDF"
              echo "  latexmk draft.tex          # automatic compilation (recommended)"
              echo ""
            '';
          };
      });
    };
}
