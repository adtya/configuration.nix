set quiet
hostname := shell('hostname')

update:
  nix flake update
  git add flake.lock
  git commit -m "Update inputs"

build host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nixos-rebuild --flake .#{{host}} build; \
  else \
  nixos-rebuild --build-host {{host}} --target-host {{host}} --flake .#{{host}} build; \
  fi

deploy host:
  if [ "{{host}}" = "{{hostname}}" ]; then \
  nixos-rebuild --flake .#{{host}} switch; \
  else \
  deploy --skip-checks --remote-build --targets .#{{host}}; \
  fi
