{ ... }: {
  programs.git = {
    enable = true;
    userName = "NathanielWroblewski";
    userEmail = "nathanielwroblewski@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
