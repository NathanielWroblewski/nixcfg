{ pkgs, ... }: {
  packages = with pkgs; [
    pegasus-frontend # retroarch front-end, es-de was pulled due to CVEs in a dependency

    # standalone emulators
    ryubing # switch
    cemu # wiiu
    dolphin-emu # gamecube/wii
    xemu # xbox

    # retroarch with selected libretro cores
    (retroarch.withCores (cores: with cores; [
      # nintendo cores
      mesen # nes
      bsnes # snes
      sameboy # gameboy {,color}
      mgba # gameboy advance
      mupen64plus # n64
      melonds # nds
      citra # 3ds

      # snk cores
      fbneo # neo geo
      beetle-ngp # neo geo pocket {,color}

      # sega cores
      genesis-plus-gx # master system, genesis, game gear
      picodrive # 32x
      beetle-saturn # saturn
      flycast # dreamcast

      # atari cores
      beetle-lynx # lynx
      virtualjaguar # jaguar

      dosbox-pure # ms dos
      mame # arcade
      beetle-pce # turbografx16
      opera # 3do

      # sony cores
      beetle-psx # playstation
      pcsx2 # ps2
      ppsspp # psp
    ]))
  ];
}
