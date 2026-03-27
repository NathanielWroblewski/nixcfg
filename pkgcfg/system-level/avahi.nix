{
  # Enables auto-discovery of wireless network printers
  # Discovery is performed over port 5353
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
