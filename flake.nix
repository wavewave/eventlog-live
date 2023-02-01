{
  description = "eventlog-live";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
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
      hsPkgs = pkgs.haskell.packages.ghc944;
      hsenv = hsPkgs.ghcWithPackages (p: []);
      shell = pkgs.mkShell {
        buildInputs = [
          hsenv
          pkgs.alejandra # nix expression formatter
        ];
      };
    in {
      devShells.default = shell;
    });
}
