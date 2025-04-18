set quiet
hostname := shell('hostname')

update:
  nix flake update
  git add flake.lock
  git commit -m "Update inputs"

build host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nh os build -H {{host}} .; \
  else \
  nixos-rebuild --build-host {{host}} --target-host {{host}} --flake .#{{host}} build; \
  fi

boot host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nh os boot -H {{host}} .; \
  else \
  nixos-rebuild --build-host {{host}} --target-host {{host}} --flake .#{{host}} boot; \
  fi

deploy host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nh os switch -H {{host}} .; \
  else \
  deploy --skip-checks --remote-build --targets .#{{host}}; \
  fi
