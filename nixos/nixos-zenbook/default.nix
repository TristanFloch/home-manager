{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/tristan

    ../common/optional/docker.nix
    ../common/optional/filesystems.nix
    ../common/optional/fish.nix
    ../common/optional/gnome.nix
    ../common/optional/pipewire.nix
    ../common/optional/systemd-boot.nix
  ];

  networking = {
    hostName = "nixos-zenbook";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE connect
        { from = 8081; to = 8081; } # Expo Go
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE connect
        { from = 8081; to = 8081; } # Expo Go
      ];
    };
  };

  # Enable printers
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  services.displayManager.autoLogin.enable = false;

  programs.dconf.enable = true;

  # TODO set this up using home-manager
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
