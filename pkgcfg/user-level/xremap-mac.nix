{
  services.xremap = {
    enable = true;

    serviceMode = "user";
    userName = "nathaniel";

    withGnome = true;

    config.keymap = [
      {
        name = "[Global cmd to ctrl]";
        remap = {
          "Super-c" = "Ctrl-c";
          "Super-v" = "Ctrl-v";
          "Super-a" = "Ctrl-a";
          "Super-t" = "Ctrl-t";
          "Super-w" = "Ctrl-w";
        };
      }
      {
        name = "[Alacritty] cmd+{c,v} to {copy,paste}";
        application.only = [ "alacritty" ];
        remap = {
          "Super-c" = "Ctrl-Shift-c";
          "Super-v" = "Ctrl-Shift-v";
        };
      }
    ];
  };
}
