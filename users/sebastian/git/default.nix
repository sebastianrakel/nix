{ config, pkgs, unstable, ... }:
{
  programs.git = {
    enable = true;
    userName = "Sebastian Rakel";
    userEmail = "sebastian@devunit.eu";
    signing = {
      signByDefault = true;
      key = "779EBA5EB9D631B8";
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      sts = "status -s";
      br = "for-each-ref --sort=-committerdate refs/heads/ refs/remotes/origin/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' -";
      ba = "branch -a";
      type = "cat-file -t";
      dump = "cat-file -p";
      sl = "log --pretty=log --date=iso --decorate=short";
      l = "log --graph --pretty=log --date=relative --decorate=short";
      pu = "push";
      put = "push --tags";
      pl = "pull";
      fl = "log --color --all --date-order --decorate --stat";
      lg = "log --graph --abbrev-commit --color --pretty=log";
      lf = "lg --name-status";
      pfusch = "push --force";
      con = "checkout -b";
      s = "status";
      a = "add";
      fat = "fetch --all --tags";
      nb = "con";
    };
    includes = [
      {
        path = "${config.home.homeDirectory}/.config/git/conf.d/private";
      }
    ];
  };
}
