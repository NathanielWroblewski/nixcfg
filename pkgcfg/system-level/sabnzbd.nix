{ constants, ... }:
{
  services.sabnzbd = {
    enable = true;
    openFirewall = true;
    user = constants.users.nathaniel;
  };
}
