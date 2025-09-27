{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;


    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "systemd"
        "history"
        "colored-man-pages"
        "command-not-found"
        "dirhistory"
        "fzf"
      ];
      extraConfig = ''

        HIST_STAMPS="yyyy-mm-dd"


        ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
        ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓"


        DISABLE_AUTO_UPDATE="true"
        DISABLE_UPDATE_PROMPT="true"
      '';
    };


    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
      extended = true;
    };


    shellAliases = {

      ll = "eza -la --icons";
      la = "eza -la --icons";
      l = "eza -l --icons";
      ls = "eza --icons";
      tree = "eza --tree --icons";
      cat = "bat";
      grep = "rg";
      find = "fd";
      c = "clear";


      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";


      rebuild = "sudo nixos-rebuild switch --flake ~/nix";
      nix-search = "nix search nixpkgs";


      gst = "git status";
      gaa = "git add --all";
      gcmsg = "git commit -m";
      gp = "git push";
      gpl = "git pull";
      glo = "git log --oneline";
      glog = "git log --oneline --graph --all";


      hypr-reload = "hyprctl reload";
    };


    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      PAGER = "bat";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";

      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };


    initContent = ''

      mkcd() {
        mkdir -p "$1" && cd "$1"
      }


      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1" ;;
            *.tar.gz)    tar xzf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar e "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.tar)       tar xf "$1" ;;
            *.tbz2)      tar xjf "$1" ;;
            *.tgz)       tar xzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1" ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }


      fcd() {
        local dir
        dir=$(find . -type d -not -path '*/.*' 2>/dev/null | fzf) && cd "$dir"
      }

      if command -v zoxide &> /dev/null; then
        eval "$(zoxide init zsh)"
      fi
    '';
  };


  home.packages = with pkgs; [
    eza
    bat
    fd
    ripgrep
    fzf
    tree
    btop
    zoxide

    git
    gh
    delta
  ];


  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
      "--preview 'bat --color=always --style=header,grid --line-range :300 {}'"
    ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };


  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -FR";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}

