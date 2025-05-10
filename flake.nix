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

    defaultPackageName = "nvim";
    luaPath = ./.;

    dependencyOverlays = [
      (utils.sanitizedPluginOverlay inputs)
    ];

    categoryDefinitions = {
      pkgs,
      settings,
      categories,
      extra,
      name,
      ...
    } @ packageDef: {
      lspsAndRuntimeDeps = with pkgs; {
        lsp = [
          lua-language-server
          nixd
          haskell-language-server
        ];
        formatters = [
          stylua
          alejandra
          # alternative nix formatter:
          # nixfmt-rfc-style
        ];
        telescope = [
          ripgrep
          fd
        ];
        latex = [
          texliveBasic
        ];
      };

      startupPlugins = with pkgs;
        {
          general = with vimPlugins;
            [
              nvim-treesitter.withAllGrammars
              # (nvim-treesitter.withPlugins (
              #   p: with p; [
              #     lua
              #     nix
              #   ]
              # ))
              oil-nvim
              nvim-autopairs
              lz-n
              gitsigns-nvim
            ]
            ++ (with neovimPlugins; [
              spaceduck
            ]);
        }
        // (with vimPlugins; {
          lsp = [
            nvim-lspconfig
            lazydev-nvim
          ];
          formatters = [
            conform-nvim
          ];
          telescope = [
            telescope-nvim
            telescope-fzf-native-nvim
          ];
          latex = [
            vimtex
          ];
        });
      # optionalPlugins = with pkgs.vimPlugins; {};
    };

    packageDefinitions.${defaultPackageName} = {
      pkgs,
      name,
      ...
    }: {
      categories = {
        general = true;
        lsp = true;
        formatters = true;
        telescope = true;
        latex = false;
      };
    };
  in let
    nixCatsBuilder = utils.baseBuilder luaPath {inherit dependencyOverlays pkgs;} categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
  in {
    packages.${system} = utils.mkAllWithDefault defaultPackage;

    devShells.default = pkgs.mkShell {
      name = defaultPackageName;
      packages = defaultPackage;
    };
  };
}
