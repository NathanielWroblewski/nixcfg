{ username }:
let
  home = "/home/${username}";
in
{
  ssh_private_key = "${home}/.ssh/id_ed25519";
  ssh_public_key = "${home}/.ssh/id_ed25519.pub";
}
