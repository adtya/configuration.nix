_: {
  networking = {
    firewall = {
      allowedTCPPorts = [
        41414 # Torrent
        53317 # LocalSend
      ];
      allowedUDPPorts = [
        6771 # Torrent
        41414 # Torrent
        53317 # LocalSend
      ];
    };
  };
}
