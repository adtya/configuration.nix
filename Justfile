set quiet
hostname := shell('hostname')

update:
  nix flake update
  git add flake.lock
  git commit -m "Update inputs"

build builder target:
  if [ "{{target}}" = "{{hostname}}" ]; then \
  nh os build -H {{target}} .; \
  else \
  nixos-rebuild --no-reexec --build-host {{builder}} --target-host {{target}} --flake .#{{target}} build; \
  fi

boot builder target:
  if [ "{{target}}" = "{{hostname}}" ]; then \
  nh os boot -H {{target}} .; \
  else \
  nixos-rebuild --no-reexec --build-host {{builder}} --target-host root@{{target}} --flake .#{{target}} boot; \
  fi

deploy host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nh os switch -H {{host}} .; \
  else \
  deploy --skip-checks --remote-build --targets .#{{host}}; \
  fi
