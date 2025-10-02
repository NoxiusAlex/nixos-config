{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    rr
    gdb
   vscode-extensions.vadimcn.vscode-lldb 
  ];

  home.sessionVariables = {
    CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # LSP серверы
      bash-language-server           # bashls
      vscode-langservers-extracted   # cssls, html, jsonls
      eslint_d                       # eslint
      graphql-language-service-cli   # graphql
      lua-language-server            # lua_ls
      prisma-engines                 # prismals
      tailwindcss-language-server    # tailwindcss
      # typescript-language-server уже включен в typescript-tool

      # additional plugins
      gnumake
      lazygit
      clang-tools
      nodejs_20
      gcc
      pnpm
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  # xdg.configFile."nvim/parser".source =
  #   let
  #     parsers = pkgs.symlinkJoin {
  #       name = "treesitter-parsers";
  #       paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
  #         c
  #         lua
  #       ])).dependencies;
  #     };
  #   in
  #   "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  home.file.".config/nvim".source = ./nvim;
  home.file.".config/nvim".recursive = true;
}
