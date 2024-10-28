{
  logFormat = ''
    output stderr
    format json
    level ERROR
  '';

  tlsAcmeDnsChallenge = ''
    tls {
      dns hetzner {env.HETZNER_ACCESS_TOKEN}
    }
  '';
}
