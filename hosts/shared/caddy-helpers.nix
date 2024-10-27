{
  logFormat = fileName: ''
    output stderr
    format json
    level DEBUG
  '';

  tlsDNSChallenge = ''
    tls {
      dns digitalocean {env.DO_API_TOKEN}
    }
  '';
}
