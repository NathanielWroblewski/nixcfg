{
  # really unfortunate requirement to run sublime text 4 currently
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
