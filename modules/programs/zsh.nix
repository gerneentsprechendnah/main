{ pkgs, config, home-manager, ... }:

{
 programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake .#desktop";
    garbage = "sudo nix-store -gc";
    };
  histSize = 10000;
  ohMyZsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
  };
 };

programs.thefuck = {
  enable = true;
};

}
