{
  self,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = lib.autoImport ./.;
  options.tlehman.enable = lib.mkEnableOption "Tobi's custom darwin modules";
  config = {
    tlehman = {
      homebrew.enable = lib.mkDefault true;
      macos-defaults.enable = lib.mkDefault true;
    };
    system = {
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      stateVersion = 5;
      # Set Git commit hash for darwin-version.
      configurationRevision = self.rev or self.dirtyRev or null;
      #
      primaryUser = username;
    };

    environment = {
      systemPackages = [
        pkgs.home-manager
        pkgs.pstree
      ];
      shellAliases =
        let
          nh = lib.getExe pkgs.nh;
        in
        {
          nrs = "NH_NO_CHECKS=1 ${nh} darwin switch ~/src/tlehman/dotfiles";
          nrt = "NH_NO_CHECKS=1 ${nh} darwin test ~/src/tlehman/dotfiles";
        };
      etc."pam.d/sudo_local".text = ''
        # Allow for touch ID to work for sudo, inside of tmux
        auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
        auth       sufficient     pam_tid.so
      '';
    };

    security.pam.services.sudo_local.touchIdAuth = true;

    # Disable documentation generation to avoid builtins.toFile warnings
    # with custom module options
    documentation.enable = false;

    fonts.packages = builtins.attrValues {
      inherit (pkgs.nerd-fonts)
        jetbrains-mono
        ;
    };

    programs = {
      zsh.enable = true;
      nh.enable = true;
    };

    # Cannot let nix-darwin control nix when using determinate
    nix.enable = lib.mkForce false;
    nixpkgs = {
      config.allowUnfree = false;
    };
  };
}
