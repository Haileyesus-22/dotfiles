{ config, pkgs, ... }:

{
  home.username = "haidev";
  home.homeDirectory = "/home/haidev";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # ── Tools ─────────────────────────────────────────────────
  home.packages = with pkgs; [
    ripgrep      # fast grep, used by neovim telescope
    fzf          # fuzzy finder
    fd           # fast find
    bat          # better cat
    eza          # better ls
    zoxide       # smart cd
    git
    gh           # github cli
    lazygit      # git TUI
    nodejs
    rustup
  ];

  # ── Git ───────────────────────────────────────────────────
  programs.git = {
    enable = true;
    settings = {
    user.name = "Haileyesus-22";
    user.email = "hahube22to21@gmail.com";
    init.defaultBranch = "main";
    push.autoSetupRemote = true;
    };
  };

  # ── Zsh ───────────────────────────────────────────────────
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      cat = "bat";
      cd = "z";
      v = "nvim";
      hms = "home-manager switch";
    };
    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  # ── Neovim ────────────────────────────────────────────────
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;

    initLua = builtins.readFile ./nvim/init.lua;

    plugins = with pkgs.vimPlugins; [
      # theme
      catppuccin-nvim

      # file tree
      nvim-tree-lua
      nvim-web-devicons

      # fuzzy finder
      telescope-nvim
      plenary-nvim

      # syntax highlighting
      nvim-treesitter.withAllGrammars

      # status line
      lualine-nvim

      # lsp
      nvim-lspconfig

      # autocompletion
      nvim-cmp
      cmp-nvim-lsp
      luasnip

      # git signs in gutter
      gitsigns-nvim

      # autopairs
      nvim-autopairs

      # comments
      comment-nvim
    ];
  };
}
