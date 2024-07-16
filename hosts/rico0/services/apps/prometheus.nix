_: {
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "frp";
        static_configs = [
          { targets = [ "10.10.10.1:7500" ]; }
        ];
      }
      {
        job_name = "blocky";
        static_configs = [
          { targets = [ "10.10.10.10:8080" ]; }
        ];
      }
    ];
  };
}
