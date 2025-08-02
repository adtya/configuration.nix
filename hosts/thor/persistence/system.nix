_: {
  environment.persistence."/persist/state" = {
    hideMounts = true;
    directories = [
      "/etc/lact"
      "/var/lib/libvirt"
    ];
  };
}
