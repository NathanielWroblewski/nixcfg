{ pkgs, constants, ... }:
let
  users = constants.users;
in
{
  services.greetd = {
    enable = false;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri";
        user = users.nathaniel;
      };
    };
  };
}
