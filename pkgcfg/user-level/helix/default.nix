{
  imports = [ ./languages ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha_transparent";
      editor = {
        clipboard-provider = "wayland";
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        mouse = true;
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        indent-guides.render = true;
        inline-diagnostics.cursor-line = "hint";
      };
    };
    themes = {
      catppuccin_mocha_transparent = {
        "inherits" = "catppuccin_mocha";
        "ui.background" = { };
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  features.editor.helix = {
    javascript.enable = true;
    json.enable = true;
    jsx.enable = true;
    nix.enable = true;
    rust.enable = true;
    toml.enable = true;
    tsx.enable = true;
    typescript.enable = true;
    yaml.enable = true;
  };
}
