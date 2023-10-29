{ stdenvNoCC, python3, fetchFromGitLab, ...}: {
  pname = "dracula-gtk";
  version = "unstable-2023-10-14";
  src =fetchFromGitLab {
  group = "smc";
  owner = "fonts";
  repo = "manjari";
  rev = "b683d1be36657ba7bf0689ce94e71f1edb9fce86";
  hash = "sha256-YR6gCYhPTB6D7/HoCZMb0o91GFH1C+cLjAaiH3jt9Rc=";
};

}
