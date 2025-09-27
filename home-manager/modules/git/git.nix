{
  programs.git = {
    enable = true;
    userName = "NoxiusAlex";
    userEmail = "alex@demkino.ru";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        light = false;
        line-numbers = true;
        syntax-theme = "Dracula";
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
