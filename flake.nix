{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}: let
    systems = nixpkgs.lib.systems.flakeExposed;
  in {
    formatter = nixpkgs.lib.genAttrs systems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.alejandra
    );
    devShells = nixpkgs.lib.genAttrs systems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {permittedInsecurePackages = ["python-2.7.18.8"];};
      };
      # pkgs = nixpkgs.legacyPackages.${system};
      c3c = pkgs.callPackage ./nix/c3c.nix {};
      autobahntestsuite = pkgs.callPackage ./nix/abts.nix {};
    in {
      default = pkgs.mkShell {
        packages =
          builtins.attrValues {inherit (pkgs) nixd nil alejandra;}
          ++ [autobahntestsuite c3c];
      };
    });
  };
}
