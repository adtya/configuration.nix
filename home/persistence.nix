{ config, ... }:
let
  linkTo = config.lib.file.mkOutOfStoreSymlink;
  persist = "/persist/home";
in
{
  xdg.configFile = {
    "nixos".source = linkTo "${persist}/.config/nixos";
  };
  home.file = {
    documents = {
      source = linkTo "${persist}/Documents";
      target = "Documents";
    };
    downloads = {
      source = linkTo "${persist}/Downloads";
      target = "Downloads";
    };
    others = {
      source = linkTo "${persist}/Others";
      target = "Others";
    };
    pictures = {
      source = linkTo "${persist}/Pictures";
      target = "Pictures";
    };
    projects = {
      source = linkTo "${persist}/Projects";
      target = "Projects";
    };
    videos = {
      source = linkTo "${persist}/Videos";
      target = "Videos";
    };
  };
}
