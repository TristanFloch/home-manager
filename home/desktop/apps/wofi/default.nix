{ config, lib, pkgs, ... }:

let
  wayland = config.modules.desktop.sessions.wayland;
in
{
  config = lib.mkIf wayland.enable {
    home.packages = with pkgs; [
      wofi
    ];
  };
}