{ lib, ... }: {
  networking = {
    nameservers = [
      "10.10.10.11"
    ];
    useDHCP = lib.mkDefault false;
  };

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [ ];
  };
}
