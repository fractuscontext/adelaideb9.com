{
  description = "A simple development environment for Vue 3 + Vite";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
       Caleb = "test";
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            pnpm_9
            typescript
            nodejs_24
            reuse
            markdownlint-cli
            nixpkgs-fmt
          ];
        };
      });
}
