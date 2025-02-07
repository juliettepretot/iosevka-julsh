{
  description = "Font development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            fontforge
            ttfautohint
            nodejs
            python3
            uv
            git  # Add git here
          ];

          shellHook = ''
            echo "Font development shell"
            echo "Python version: $(python3 --version)"

            # Set up uv virtual environment
            if [ ! -d ".venv" ]; then
              uv venv .venv
              uv pip install -r requirements.txt
            fi
            source .venv/bin/activate
          '';
        };
      });
}
