{
  logFormat = fileName: ''
    output file /var/log/caddy/${fileName}.log {
      roll_size 100MiB
      roll_keep 5
      roll_keep_for 100d
    }
    format json
    level INFO
  '';
}
