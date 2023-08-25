{ pkgs }:
let
  inherit (builtins) attrNames filter readDir listToAttrs;
  dirs = let files = readDir ./.;
  in filter (name: files."${name}" == "directory") (attrNames files);
in listToAttrs (map (dir: {
  name = dir;
  value = pkgs.callPackage ./${dir} { };
}) dirs)
