{
  logFormat = ''
    output stderr
    format json
    level INFO
  '';

  tlsAcmeDnsChallenge = ''
    tls {
      dns digitalocean {env.DO_API_TOKEN}
    }
  '';
}
