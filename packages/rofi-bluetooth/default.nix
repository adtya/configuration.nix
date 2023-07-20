{
  lib,
  fetchFromGitHub,
  makeWrapper,
  stdenvNoCC,
  bluez,
  rofi-wayland,
}:
stdenvNoCC.mkDerivation {
  pname = "rofi-bluetooth";
  version = "git";
  src = fetchFromGitHub {
    owner = "nickclyde";
    repo = "rofi-bluetooth";
    rev = "9d91c048ff129819f4c6e9e48a17bd54343bbffb";
    hash = "sha256-1Xe3QFThIvJDCUznDP5ZBzwZEMuqmxpDIV+BcVvQDG8=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin

    cp rofi-bluetooth $out/bin/rofi-bluetooth
    chmod +x $out/bin/rofi-bluetooth

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/rofi-bluetooth --prefix PATH : ${lib.makeBinPath [bluez rofi-wayland]}
  '';
}
