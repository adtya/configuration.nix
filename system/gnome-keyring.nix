{ ... }:
{
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.passwd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
