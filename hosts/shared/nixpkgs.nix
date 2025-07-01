# nixpkgs configuration shared across all hosts/devices

{ outputs, ... }: {
  nixpkgs = {
    # Specify overlays to add or modify dependency packages
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure nixpkgs instance
    config = {
      # Allow packages which aren't FOSS, e.g. zoom, slack, spotify, etc.
      allowUnfree = true;
    };
  };
}
