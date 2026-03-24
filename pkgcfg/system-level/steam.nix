# For any issues, run `$ steam -dev -console` to read output
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
