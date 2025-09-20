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
    firefox
    gcc
    telegram-desktop
    ntfs3g
    nil
    wl-clipboard
    nix-prefetch
    openssl
    yad
    prismlauncher
    pavucontrol
    nftables
    hyprshot
    brave
    nautilus
    hyprpicker
    wf-recorder
    slurp
    quickemu
    spotify
    quickgui
    qmk
    qmk-udev-rules # the only relevant
    qmk_hid
    via
    vial
    mpv
    glslls
    qt6.full
    calibre
    zoom-us
    os-prober
    jetbrains.clion


    # fonts
    material-symbols
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    rubik
    grim
    
  ]) ++ ([
    aniparser
    (pkgs.callPackage ./screen-rec.nix {})
    caelestia-cli
  ]);

}
