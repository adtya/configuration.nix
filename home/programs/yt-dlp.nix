{ ... }: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
    };
  };
}
