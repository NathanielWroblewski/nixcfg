{ pkgs, ... }:
{
  # Enable CUPS to print documents.  Available at localhost:631
  # if any printers have cxn /dev/null, edit them to IPPS everywhere
  services.printing = {
    enable = true;

    drivers = with pkgs; [
      hplipWithPlugin # HP printer drivers
    ];
  };
}
