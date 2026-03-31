{
  services.udev.extraRules = ''
    # Disable the mouse interface on NuPhy Air75 V3 keyboard (vid:19f5 pid:1028 iface:02)
    # This interface sends phantom mouse button events that interfere with niri window management
    KERNEL=="event*", ENV{ID_VENDOR_ID}=="19f5", ENV{ID_MODEL_ID}=="1028", ENV{ID_USB_INTERFACE_NUM}=="02", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
