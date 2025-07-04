{ pkgs, constants, ... }:
let
  users = constants.users;
in
{
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = users.greeter;
      };
    };
  };
}
