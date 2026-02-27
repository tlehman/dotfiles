# bender - personal Apple Silicon Mac
#
{
  networking.hostName = "bender";

  home-manager.users.tobi = {
    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.ssh.matchBlocks.tars = {
      hostname = "100.95.235.90";
      identityFile = "~/.ssh/id_tars";
    };
  };
}
