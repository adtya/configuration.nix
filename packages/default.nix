final: prev: {
  adi1090x-plymouth = prev.callPackage ./adi1090x-plymouth { };
  dracula-gtk = prev.callPackage ./dracula-gtk { };
  scripts = prev.callPackage ./scripts { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-manjari = prev.callPackage ./smc-manjari { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };
}
