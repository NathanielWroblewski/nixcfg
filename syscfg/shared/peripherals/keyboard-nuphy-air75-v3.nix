{
  services.udev.extraRules = ''
    # NuPhy Air75 V3 - disable NKRO interface (iface 01) which sends phantom modifier events
    # that interfere with niri window management
    KERNEL=="event*", ENV{ID_VENDOR_ID}=="19f5", ENV{ID_MODEL_ID}=="1028", ENV{ID_USB_INTERFACE_NUM}=="01", ENV{LIBINPUT_IGNORE_DEVICE}="1"

    # Disable the mouse interface on NuPhy Air75 V3 keyboard (vid:19f5 pid:1028 iface:02)
    # I suspect this interface may send phantom mouse button events
    # that interfere with niri window management, e.g. when super is pressed
    KERNEL=="event*", ENV{ID_VENDOR_ID}=="19f5", ENV{ID_MODEL_ID}=="1028", ENV{ID_USB_INTERFACE_NUM}=="02", ENV{ID_INPUT_MOUSE}=="1", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # Reboot after modifying and applying the changes.

  # You can check that the rule was applied with the following:
  # $ sudo udevadm info /dev/input/event12 | grep LIBINPUT
  # > LIBINPUT_DEVICE_GROUP=....
  # > LIBINPUT_IGNORE_DEVICE=1

  # When properly ignored, the following should return empty sets
  # $ sudo udevadm trigger /dev/input/event12
  # $ sudo libinput list-devices | grep -A3 "Air75.*Mouse"

  # Occassionally the user will be dropped into a window resize mode permanently where
  # most keyboard input is also ignored.  Disabling the virtual mouse input of this
  # keyboard, and disabling the duplicate virtual keyboard layer, prevents entering this
  # state. Evidence collected from a libinput monitor (syscfg/workbench/libinput-monitor.nix)
  # indicated the virtual keyboard layer was triggering long-held super key press events.
}
