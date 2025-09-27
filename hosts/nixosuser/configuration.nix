{
  pkgs,
  stateVersion,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/modules
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
  services.power-profiles-daemon.enable = true;
}
