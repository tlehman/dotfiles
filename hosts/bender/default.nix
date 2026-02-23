# bender - personal Apple Silicon Mac
#
{
  networking.hostName = "bender";

  home-manager.users.tobi.home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
