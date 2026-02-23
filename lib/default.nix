{
  self,
  outputs,
  inputs,
}:
let
  inherit (outputs) lib;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (lib)
    filter
    forEach
    mkEnableOption
    mkPackageOption
    optionalString
    ;
in
{
  mkHomeManager = username: {
    home-manager = {
      backupFileExtension = "hm.bak";
      useUserPackages = true;
      useGlobalPkgs = true;
      users."${username}" = {
        imports = [ outputs.homeModules.tlehman ];
        tlehman.enable = true;
        home.stateVersion = "24.11";
        home.homeDirectory = lib.mkForce "/Users/${username}";
      };
      extraSpecialArgs = { inherit inputs username; };
    };
  };

  mkDarwin =
    hostmodule: username:
    darwinSystem {
      specialArgs = {
        inherit
          self
          inputs
          outputs
          lib
          username
          ;
      };
      modules = [
        hostmodule
        inputs.home-manager.darwinModules.home-manager
        outputs.darwinModules.tlehman
        (lib.mkHomeManager username)
        {
          tlehman.enable = true;
          nixpkgs = {
            hostPlatform = "aarch64-darwin";
          };
        }
      ];
    };

  # read a directory and return a list of all filenames inside except any default.nix
  # ripped from: https://github.com/EarthGman/nix-library/blob/main/lib/default.nix#L15
  autoImport =
    dir:
    let
      fileNames = builtins.attrNames (builtins.readDir dir);
      strippedFileNames = filter (name: name != "default.nix") fileNames;
    in
    forEach strippedFileNames (fileName: dir + /${fileName});

  mkProgramOption =
    {
      pkgs,
      programName,
      packageName ? programName,
      description ? null,
      extraPackageArgs ? { },
    }:
    {
      enable = mkEnableOption (programName + " " + optionalString (description != null) description);
      package = mkPackageOption pkgs packageName extraPackageArgs;
    };

}
