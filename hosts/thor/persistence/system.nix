_: {
  environment.persistence."/persist/state" = {
    hideMounts = true;
    directories = [ "/var/lib/libvirt" ];
  };
}
