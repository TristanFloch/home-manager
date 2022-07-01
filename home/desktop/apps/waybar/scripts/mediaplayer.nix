{ config, lib, pkgs, ... }:

with pkgs.python3Packages;

buildPythonApplication {
  pname = "waybar-mediaplayer";
  version = "1.0";

  nativeBuildInputs = with pkgs; [
    wrapGAppsHook # TODO try without this
    gobject-introspection
  ];

  propagatedBuildInputs = with pkgs; [
    playerctl
    glib
    python3
    python39Packages.setuptools
    python39Packages.pygobject3
  ];
  strictDeps = false; # TODO try without this

  src = ./mediaplayer;
}
