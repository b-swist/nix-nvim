{
  description = "Minimal Neovim flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    inherit (inputs.nixCats) utils;

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    packageName = "nvim";

    categoryDefinitions = { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
      lspsAndRuntimeDeps.default = with pkgs; [
        lua-language-server
        haskell-language-server
        nixd
      ];

      startupPlugins.default = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        nvim-autopairs
      ];

      optionalPlugins.default = with pkgs.vimPlugins; [
        vimtex
      ];
    };

    packageDefinitions.${packageName} = { pkgs, name, mkPlugin, ... }: {
      # settings = {
      #   suffix-path = true;
      #   suffix-LD = true;
      # };
      categories.default = true;
      # extra = {};
    };
  in {
    packages.${system} = utils.mkAllWithDefault (utils.baseBuilder ./. { inherit pkgs; } categoryDefinitions packageDefinitions packageName);
  };
}
