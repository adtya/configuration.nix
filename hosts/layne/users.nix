_: {
  users = {
    users = {
      mediaserver = {
        group = "mediaserver";
        uid = 899;
        isSystemUser = true;
        description = "Media Server user";
      };
    };

    groups = {
      mediaserver = {
        gid = 899;
      };
    };
  };
}
