{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    nixpkgs,
    self,
    ...
  }: let
    systems = nixpkgs.lib.systems.flakeExposed;
  in {
    formatter = nixpkgs.lib.genAttrs systems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.alejandra
    );
    packages = nixpkgs.lib.genAttrs systems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        c3c = pkgs.callPackage ./nix/c3c.nix {};
        c3-lsp = pkgs.callPackage ./nix/c3-lsp.nix {};
      in {inherit c3c c3-lsp;}
    );
    devShells = nixpkgs.lib.genAttrs systems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-self = self.packages.${system};
    in {
      default = pkgs.mkShell {
        packages = builtins.attrValues {
          inherit (pkgs) nixd nil alejandra;
          inherit (pkgs-self) c3c c3-lsp;
        };
      };
    });
  };
}
