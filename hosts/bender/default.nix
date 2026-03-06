# bender - personal Apple Silicon Mac
#
{
  networking.hostName = "bender";

  home-manager.users.tobi = {
    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.ssh.matchBlocks.tars = {
      hostname = "100.117.255.86";
      identityFile = "~/.ssh/id_tars";
    };
  };
}
