{ pkgs, ... }:
let
  snowflake = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in
{
  programs.librewolf = {
    enable = true;

    profiles.browsing = {
      isDefault = true;

      # additional settings found in about:config in browser
      settings = {
        "browser.download.panel.shown" = true;
        "browser.startup.homepage" = "https://search.brave.com/search";
        "browser.startup.firstrunSkipsHomepage" = false;
        "extensions.autoDisableScopes" = 0;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = false; # requires a limiting browsing experience
        "webgl.disabled" = false;
      };

      # Provide a CSS string
      # userChrome = '';

      extensions = {
        force = true;
        packages = with pkgs.firefox-addons; [
          pkgs.firefox-addons."1password-x-password-manager"
          absolute-enable-right-click
          amp2html
          catppuccin-mocha-mauve
          decentraleyes
          don-t-fuck-with-paste
          gaoptout
          metamask
          new-tab-override
          react-devtools
          sponsorblock
          ublock-origin
        ];
      };

      # bookmarks = {
      #   force = true;
      #   settings = { };
      # };

      search = {
        force = true;
        default = "Brave";
        privateDefault = "Brave";

        engines = {
          nixpkgs = {
            definedAliases = [ "@np" ];
            icon = snowflake;
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nixosOptions = {
            definedAliases = [ "@no" ];
            icon = snowflake;
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          myNixOS = {
            definedAliases = [ "@nm" ];
            icon = snowflake;
            urls = [
              {
                template = "https://mynixos.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          noogle = {
            definedAliases = [ "@ng" ];
            urls = [
              {
                template = "https://noogle.dev/q";
                params = [
                  {
                    name = "term";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          perplexity = {
            definedAliases = [ "@p" ];
            urls = [
              {
                template = "https://perplexity.ai/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          youtube = {
            definedAliases = [ "@yt" ];
            urls = [
              {
                template = "https://youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          emojis = {
            definedAliases = [ "@e" ];
            urls = [
              {
                template = "https://emojifinder.com";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          brave = {
            definedAliases = [ "@b" ];
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "source";
                    value = "web";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
