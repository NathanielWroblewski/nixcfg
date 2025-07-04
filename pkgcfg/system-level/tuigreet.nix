{ pkgs, constants, ... }:
let
  users = constants.users;
in
{
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri";
        user = users.nathaniel;
      };
    };
  };
}
