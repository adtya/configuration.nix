{ lib, fetchFromGitHub, buildGoModule, installShellFiles }:
let
  version = "2.9.1";
  caddy-src = fetchFromGitHub {
    owner = "caddyserver";
    repo = "dist";
    rev = "v${version}";
    hash = "sha256-us1TnszA/10OMVSDsNvzRb6mcM4eMR3pQ5EF4ggA958=";
  };
in
buildGoModule {
  pname = "caddy";
  inherit version;
  src = ./src;
  runVend = true;
  vendorHash = "sha256-rH4J33idvgkAmXF3NbHolifUwcq7EEIP7zJUy+Qvorw=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/caddyserver/caddy/v2.CustomVersion=${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    install -Dm644 ${caddy-src}/init/caddy.service ${caddy-src}/init/caddy-api.service -t $out/lib/systemd/system

    substituteInPlace $out/lib/systemd/system/caddy.service --replace "/usr/bin/caddy" "$out/bin/caddy"
    substituteInPlace $out/lib/systemd/system/caddy-api.service --replace "/usr/bin/caddy" "$out/bin/caddy"

    $out/bin/caddy manpage --directory manpages
    installManPage manpages/*

    installShellCompletion --cmd caddy \
      --bash <($out/bin/caddy completion bash) \
      --fish <($out/bin/caddy completion fish) \
      --zsh <($out/bin/caddy completion zsh)
  '';
  meta = {
    homepage = "https://caddyserver.com";
    description = "Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS";
    license = lib.licenses.asl20;
    mainProgram = "caddy";
  };
}
