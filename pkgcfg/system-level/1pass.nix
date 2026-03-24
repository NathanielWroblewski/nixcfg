{
  programs._1password-gui = {
    enable = true;

    # TODO: pull username from constants
    polkitPolicyOwners = [ "nathaniel" ];
  };

  programs._1password.enable = true;
}
