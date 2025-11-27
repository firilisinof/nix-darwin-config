{ config, pkgs, lib, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  });
in
{
  home.username = "lucas";
  home.homeDirectory = lib.mkForce "/Users/lucas";

  home.packages = with pkgs; [
    duti
    age
    nodejs_24
    tex
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
      	plugin = github-nvim-theme;
        config = "colorscheme github_light";
      }
      nvim-autopairs
    ];
    extraLuaConfig = ''
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.autoindent = true

      vim.schedule(function()
        vim.o.clipboard = 'unnamedplus'
      end)
    '';
  };

  home.file.".config/ghostty/config".text = ''
    theme = GitHub Light Default
    keybind = super+f=write_scrollback_file:open
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = false;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions";
        file = "zsh-autosuggestions.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
      }
    ];

    history = {
      size = 10000;
      save = 20000;
      ignoreDups = true;
      share = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "code --wait --new-window";
    };

    initContent = lib.mkBefore ''
      export PATH=$HOME/.local/bin:$PATH
      export HISTIGNORE="pwd:ls:cd"

      autoload -Uz select-word-style
      select-word-style bash
    '';

    shellAliases = {
      ls = "ls --color=auto";
      ga = "git add";
      gc = "git commit";
      gps = "git push";
      gs = "git status";
      gpl = "git pull";
      gf = "git fetch";
      gcb = "git checkout -b";
      gp = "git push";
      gll = "git log --oneline";
      gd = "git diff";
      gco = "git checkout";
      switch = "sudo darwin-rebuild switch --flake ~/nix-darwin-config";
    };
  };
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lucas de Sousa Rosa";
      user.email = "roses.lucas404@gmail.com";
      init.defaultBranch = "main";
      
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      "*~"
      ".env"
      "node_modules/"
      "__pycache__/"
      "*.pyc"
    ];
  };

  programs.gh = {
    enable = true;
  };

  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
