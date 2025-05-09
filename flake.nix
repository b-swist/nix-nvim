{
  description = "Minimal Neovim flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-evergarden = {
      url = "github:everviolet/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    inherit (inputs.nixCats) utils;

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    defaultPackageName = "nvim";
    defaultCategoryName = "default";
    luaPath = ./.;

    dependencyOverlays = [
      (utils.sanitizedPluginOverlay inputs)
    ];

    categoryDefinitions = { pkgs, settings, categories, extra, name, ... }@packageDef: {
      lspsAndRuntimeDeps.${defaultCategoryName} = with pkgs; [
        lua-language-server
        haskell-language-server
        nixd
      ];

      startupPlugins.${defaultCategoryName} = with pkgs; (
        (with vimPlugins; [
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          nvim-autopairs
        ]) ++ (with neovimPlugins; [
          evergarden
        ])
      );

      optionalPlugins.${defaultCategoryName} = with pkgs.vimPlugins; [
        vimtex
        lazydev-nvim
      ];
    };

    packageDefinitions.${defaultPackageName} = { pkgs, name, ... }: {
      # settings = {
      #   suffix-path = true;
      #   suffix-LD = true;
      # };
      categories.${defaultCategoryName} = true;
      # extra = {};
    };
  in
    let
      nixCatsBuilder = utils.baseBuilder luaPath { inherit dependencyOverlays pkgs; } categoryDefinitions packageDefinitions;
    in {
      packages.${system} = utils.mkAllWithDefault (nixCatsBuilder defaultPackageName);
    };
}
