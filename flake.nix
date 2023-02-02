{
  description = "eventlog-live";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      hsPkgs = pkgs.haskell.packages.ghc8107;
      hsenv = hsPkgs.ghcWithPackages (p: []);
      shell = pkgs.mkShell {
        buildInputs = [
          hsenv
          pkgs.alejandra # nix expression formatter
          pkgs.cabal-install
          pkgs.socat
          pkgs.zlib
        ];
      };
    in {
      devShells.default = shell;
    });
}
