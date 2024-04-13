{ pkgs, ... }: {
  programs.nnn = {
    enable = true;
    plugins = {
      src = (pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "ad04944bdf9f4c2dc936a5a843040bf6966e619a";
        hash = "sha256-7fMmeh0YD9G3NSKsLVX3wmQuH7WO8CEms7MeXxMh0/E=";
      }) + "/plugins";
    };
  };
}
