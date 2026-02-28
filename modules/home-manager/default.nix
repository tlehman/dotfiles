{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.autoImport ./.;
  options.tlehman.enable = lib.mkEnableOption "Tobi's home module";
  config = lib.mkIf config.tlehman.enable {
    tlehman = {
      zsh.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      mkalias.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      zed.enable = lib.mkDefault true;
      helix.enable = lib.mkDefault true;
      podman-desktop.enable = lib.mkDefault true;
      k9s.enable = lib.mkDefault true;
      go.enable = lib.mkDefault true;
    };
    home.packages = with pkgs; [
      btop
      comma # https://github.com/nix-community/comma
      fd # file finding
      glow # CLI markdown reader
      jq # json querying
      just # better make
      neovim
      nil
      nixd
      nix-output-monitor # better visual output for nix builds
      ripgrep # fast grep replacement
      tldr # simplified man pages
      tmux # terminal multiplexer
      tree # print directory trees
      wget # HTTP downloading
    ];
    home.sessionVariables =
      let
        helix = "${lib.getExe pkgs.helix}";
      in
      {
        EDITOR = helix;
        VISUAL = helix;
      };
    programs = {
      bat.enable = lib.mkDefault true;
      jq.enable = lib.mkDefault true;
      lazygit.enable = lib.mkDefault true;

      direnv = {
        enable = lib.mkDefault true;
        nix-direnv.enable = lib.mkDefault true;
      };

      fzf = {
        enable = lib.mkDefault true;
        defaultCommand = "fd --type f";
        defaultOptions = [
          "--height 40%"
          "--prompt ⟫"
        ];
        changeDirWidgetCommand = "fd --type d";
        changeDirWidgetOptions = [
          "--preview 'tree -C {} | head -200'"
        ];
      };

      htop = {
        enable = lib.mkDefault true;
        settings = {
          sort_direction = true;
          sort_key = "PERCENT_CPU";
          show_program_path = false;
        };
      };

      zoxide = {
        enable = lib.mkDefault true;
        enableZshIntegration = true;
        options = [
          "--cmd"
          "j"
        ];
      };

    };
  };
}
