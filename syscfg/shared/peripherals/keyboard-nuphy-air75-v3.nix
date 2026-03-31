{
  services.udev.extraRules = ''
    # Disable the mouse interface on NuPhy Air75 V3 keyboard (vid:19f5 pid:1028 iface:02)
    # I suspect this interface may send phantom mouse button events
    # that interfere with niri window management, e.g. when super is pressed
    KERNEL=="event*", ENV{ID_VENDOR_ID}=="19f5", ENV{ID_MODEL_ID}=="1028", ENV{ID_USB_INTERFACE_NUM}=="02", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # You can check that the rule was applied with the following:
  # $ sudo udevadm info /dev/input/event12 | grep LIBINPUT
  # > LIBINPUT_DEVICE_GROUP=....
  # > LIBINPUT_IGNORE_DEVICE=1

  # When properly ignored, the following should return empty sets
  # $ sudo udevadm trigger /dev/input/event12
  # $ sudo libinput list-devices | grep -A3 "Air75.*Mouse"

  # Disabling the mouse input of this keyboard is an attempt to debug
  # an error that drops niri into a window resize mode that ignores most
  # keyboard input (ctrl+c works in an open terminal). Suspecting super +
  # a mouse input triggers the mode, and then never released.  To compliment
  # this change, a separate libinput monitor (syscfg/workbench/libinput-monitor.nix)
  # which logs events to logrotated files, has been introduced as well, to help
  # identify if a super key is being pressed and not released.  
}
