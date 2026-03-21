{
  environment.etc."wireplumber/wireplumber.conf.d/51-wave3.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [{ node.name = "alsa_input.usb-Elgato_Systems_Elgato_Wave_3_BS30K1A02542-00.mono-fallback" }]
          actions = {
            update-props = {
              node.always-process = true
            }
        }
      }
    ]
  '';
}
