_: {
  services = {
    promtail = {
      enable = true;
      configuration = {
        server = {
          http_listen_address = "127.0.0.1";
          http_listen_port = 9080;
          grpc_listen_port = 0;
        };
        clients = [
          {
            url = "https://loki.labs.adtya.xyz/loki/api/v1/push";
          }
        ];
        positions = { filename = "/tmp/promtail-positions.yaml"; };
        scrape_configs = [
          {
            job_name = "journal";
            journal = {
              json = false;
              max_age = "12h";
              path = "/var/log/journal";
              labels = { job = "systemd-journal"; };
            };
            relabel_configs = [
              {
                source_labels = [ "__journal__systemd_cgroup" ];
                target_label = "systemd_cgroup";
              }
              {
                source_labels = [ "__journal__systemd_slice" ];
                target_label = "systemd_slice";
              }
              {
                source_labels = [ "__journal__systemd_unit" ];
                target_label = "systemd_unit";
              }
              {
                source_labels = [ "__journal__systemd_user_unit" ];
                target_label = "systemd_user_unit";
              }
              {
                source_labels = [ "__journal__systemd_user_slice" ];
                target_label = "systemd_user_slice";
              }
              {
                source_labels = [ "__journal__systemd_session" ];
                target_label = "systemd_session";
              }
              {
                source_labels = [ "__journal__systemd_owner_uid" ];
                target_label = "systemd_owner_uid";
              }
              {
                source_labels = [ "__journal__hostname" ];
                target_label = "node_name";
              }
              {
                source_labels = [ "__journal_syslog_identifier" ];
                target_label = "syslog_identifier";
              }
              {
                source_labels = [ "__journal__transport" ];
                target_label = "transport";
              }
              {
                source_labels = [ "__journal__pid" ];
                target_label = "pid";
              }
              {
                source_labels = [ "__journal__uid" ];
                target_label = "uid";
              }
              {
                source_labels = [ "__journal__gid" ];
                target_label = "gid";
              }
            ];
          }
        ];
      };
    };
  };
}
