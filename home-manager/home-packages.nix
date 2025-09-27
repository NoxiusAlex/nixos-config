{ pkgs, unstable, aniparser, caelestia-cli, ... }: 
{
  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    htop
    python3
    unzip
    nodejs
    wl-clipboard
    lua-language-server
    wget
    cmatrix
    git
    fastfetch
    papirus-icon-theme
    glib
    libsForQt5.qt5ct
    qt6ct
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    jq
    bc
    swww
    upower
    brightnessctl 
    cava
    playerctl
    kitty
    gcc
    telegram-desktop
    nil
    wl-clipboard
    nix-prefetch
    openssl
    yad
    pavucontrol
    nftables
    hyprshot
    nautilus
    hyprpicker
    # wf-recorder
    # slurp
    spotify
    glslls
    qt6.full
    calibre
    zoom-us
    os-prober
    # jetbrains.clion
    thunderbird
    vulkan-tools
    lutris
    brave
    gnumake
    code-cursor
    
    # fonts
    material-symbols
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    rubik
    grim
  ]) ++ ([
    aniparser
    caelestia-cli
  ]);

}
