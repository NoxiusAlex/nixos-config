{pkgs, ...}:
{
  xdg.configFile."caelestia/cli.json".source =./cli.json;
  xdg.configFile."caelestia/shell.json".source =./shell.json;
  home.packages = with pkgs; [
    power-profiles-daemon
  ];
}
