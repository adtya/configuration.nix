{
  logFormat = ''
    output stderr
    format json
    level INFO
  '';

  tlsAcmeDnsChallenge = ''
    tls {
      dns hetzner {env.HETZNER_ACCESS_TOKEN}
    }
  '';
}
