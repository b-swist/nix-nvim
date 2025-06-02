{
  description = "(not so) minimal neovim flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-spaceduck = {
      url = "github:spaceduck-theme/nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (inputs.nixCats) utils;

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    defaultPackageName = "cvim";
    luaPath = ./.;

    dependencyOverlays = [
      (utils.sanitizedPluginOverlay inputs)
    ];

    categoryDefinitions = {pkgs, ...}: {
      lspsAndRuntimeDeps = with pkgs; {
        lsp = {
          lua = [lua-language-server];
          nix = [nixd];
          haskell = [haskell-language-server];
        };

        format = {
          lua = [stylua];
          nix = [
            alejandra
            # nixfmt-rfc-style # alternative nix formatter
          ];
          latex = [tex-fmt];
        };

        telescope = [
          ripgrep
          fd
        ];

        latex = [
          zathura
          texliveBasic
          texlivePackages.latexmk
        ];
      };

      startupPlugins.general = with pkgs; [
        vimPlugins.lze
        vimPlugins.lzextras
        neovimPlugins.spaceduck
      ];

      optionalPlugins = with pkgs.vimPlugins; {
        general = [
          oil-nvim
          nvim-autopairs
          gitsigns-nvim
        ];

        snippets = [nvim-snippy];

        treesitter = [
          nvim-treesitter.withAllGrammars
          # or install selected parsers:
          # (nvim-treesitter.withPlugins (
          #   p: with p; [
          #     lua
          #     nix
          #   ]
          # ))
        ];

        telescope = [
          telescope-nvim
          telescope-fzf-native-nvim
        ];

        lsp = {
          general = [nvim-lspconfig];
          lua = [lazydev-nvim];
        };

        format.general = [conform-nvim];
        latex = [vimtex];
      };
    };

    packageDefinitions.${defaultPackageName} = {...}: {
      settings = {
        aliases = ["nvim"];
        wrapRc = true;
      };
      categories = {
        general = true;
        snippets = true;
        treesitter = true;
        lsp = {
          general = true;
          lua = true;
          nix = true;
          haskell = false;
        };
        format = true;
        telescope = true;
        latex = true;
        colorscheme = "spaceduck";
      };
    };
  in let
    nixCatsBuilder = utils.baseBuilder luaPath {inherit dependencyOverlays pkgs;} categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    moduleNamespace = ["nixCats"];
  in {
    packages.${system} = utils.mkAllWithDefault defaultPackage;

    nixosModules.default = utils.mkNixosModules {
      inherit
        moduleNamespace
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        nixpkgs
        ;
    };

    homeModules.default = utils.mkHomeModules {
      inherit
        moduleNamespace
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        nixpkgs
        ;
    };
  };
}
