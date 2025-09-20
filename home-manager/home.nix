{ stateVersion, user, ... }:
{
  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/noxiusalex";
    stateVersion = stateVersion;
  };

  programs.home-manager.enable = true;
}
