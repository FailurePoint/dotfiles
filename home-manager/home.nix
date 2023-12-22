{ config, pkgs, inputs, lib, ... }:

{
  home.username = "monkeyd";
  home.homeDirectory = "/home/monkeyd";
  home.stateVersion = "22.11";
  nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
        bat
        fzf
        ripgrep
        jq
        tree
        exa
	];
  
  programs.neovim = {
  	enable = true;
  	viAlias = true;
	vimAlias = true;
  	};

	home.sessionVariables = {
		EDITOR="nvim";
	};
	home.shellAliases = {
		l = "exa";
		ls = "exa";
		cat = "bat";
	};

	programs.zsh = {
		enable = true;
	};

	programs.zsh.oh-my-zsh= {
		enable = true;
		plugins = ["git" "python" "docker" "fzf"];
		theme = "dpoggi";
	};

}
