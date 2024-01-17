{ pkgs, config, home-manager, ... }:

{



programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
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
  enableZshIntegration = true;
};

}
