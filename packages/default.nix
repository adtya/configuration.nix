self: super: {
  adi1090x-plymouth = super.callPackage ./adi1090x-plymouth { };
  dracula-gtk = super.callPackage ./dracula-gtk { };
  scripts = super.callPackage ./scripts { };
  rofi-bluetooth = super.callPackage ./rofi-bluetooth { };
}
