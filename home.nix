{ config, pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tristan";
    homeDirectory = "/home/tristan";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.11";

    sessionVariables = {
      EDITOR = "vim";
    };

    file = {
      ".Xresources".text = "Xft.dpi: 96";
    };
  };

  imports = [
    ./starship/main.nix
    ./bat/main.nix
    ./fish/main.nix
    ./git/main.nix
    ./vim/main.nix
    ./alacritty/main.nix
    ./gtk/main.nix
    ./rofi/main.nix
    ./picom/main.nix
    ./polybar/main.nix
    ./dunst/main.nix
    ./emacs/main.nix
    ./i3/main.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    exa
    fd
    tree
    gnupg
    picom
    slack
    rofi
    dracula-theme
    xfce.thunar
    alacritty
    htop
    fzf
    unzip
    ripgrep
    evince
    killall
    thunderbird
    pavucontrol
    clang-tools

    noto-fonts
    noto-fonts-emoji
    dejavu_fonts
    hack-font
    nerdfonts
  ];

  fonts.fontconfig.enable = true;

  services.gpg-agent.pinentryFlavor = "gtk2";
}
