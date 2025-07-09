{ pkgs, inputs, ... }:
let
  snowflake = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in
{
  programs.librewolf = {
    enable = true;

    profiles.default = {
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

      extensions = [
        inputs.firefox-addons.packages."x86_64-linux"."1password-x-password-manager"
        inputs.firefox-addons.packages."x86_64-linux".absolute-enable-right-click
        inputs.firefox-addons.packages."x86_64-linux".amp2html
        inputs.firefox-addons.packages."x86_64-linux".block-origin
        inputs.firefox-addons.packages."x86_64-linux".decentraleyes
        inputs.firefox-addons.packages."x86_64-linux".don-t-fuck-with-paste
        inputs.firefox-addons.packages."x86_64-linux".gaoptout
        inputs.firefox-addons.packages."x86_64-linux".metamask
        inputs.firefox-addons.packages."x86_64-linux".new-tab-override
        inputs.firefox-addons.packages."x86_64-linux".react-devtools
        inputs.firefox-addons.packages."x86_64-linux".sponsorblock
      ];

      bookmarks = [
        # {
        #   name = "";
        #   tags = [];
        #   keyword = "";
        #   url = "";
        # }
      ];

      search = {
        force = true;
        default = "Brave";
        privateDefault = "Brave";

        engines = {
          "NixPkgs" = {
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

          "NixOS Options" = {
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

          "MyNixOS" = {
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

          "Noogle" = {
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

          "Perplexity" = {
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

          "YouTube" = {
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

          "Emojis" = {
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

          "Brave" = {
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
