{
  description = "Tobi's Apple Nix Configuration";

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (self) outputs;
      # All of my macs are Apple ARM
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib.extend (
        _: _:
        import ./lib {
          inherit self inputs outputs;
        }
      );
    in
    {
      inherit lib;
      darwinConfigurations = {
        AMER-Tobi-Lehman = lib.mkDarwin ./hosts/AMER-Tobi-Lehman "tobi.lehman";
        bender = lib.mkDarwin ./hosts/bender "tobi";
      };
      devShells.${system}.default = pkgs.mkShell {
        name = "dotfiles";
        packages = builtins.attrValues {
          inherit (pkgs)
            deadnix
            statix
            nixfmt-tree
            just
            ;
        };
        shellHook = ''
          PATH_add "$PWD/bin"
        '';
      };
      formatter.${system} = pkgs.nixfmt-tree;
      darwinModules = rec {
        tlehman = import ./modules/darwin {
          inherit lib;
        };
        default = tlehman;
      };
      homeModules = rec {
        tlehman = ./modules/home-manager;
        default = tlehman;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
