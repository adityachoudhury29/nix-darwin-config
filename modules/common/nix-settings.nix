# Nix settings for this host.
# We deliberately keep `nix.enable = false`: the machine runs Determinate Nix
# (installed via the DeterminateSystems installer), which manages its own daemon
# and /etc/nix/nix.conf. nix-darwin's `nix.settings` still augments the
# Determinate-managed nix.conf at activation time without fighting the installer.
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Keep the existing Determinate Nix install; do not let nix-darwin manage the daemon.
  nix.enable = false;

  nix.settings = {
    # Enable flakes + nix-command for the current user and admin/root.
    experimental-features = [ "nix-command" "flakes" ];

    # Trust the user so they can pass arbitrary flakes & use nix-daemon features.
    trusted-users = [ "root" "@admin" "aditya.c.001" ];

    # Keep the existing work substituter/cache, plus the default binary cache.
    substituters = [
      "https://cache.nixos.asia/data-engg"
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "data-engg:3pdhJT2iBR1t3WCvLFp0TM0z/QvBCcWJLmvcMruKZgM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    };

  # Clean up old generations automatically.
  # NOTE: with Determinate Nix (`nix.enable = false`), store GC / optimise
  # is handled by the Determinate daemon (and `nix.gc.*` / `nix.optimise.*`
  # would require nix.enable, which we deliberately keep off). You can run
  # `nix store gc` manually when you want to reclaim space.
  #
  # nix.gc = {
  #   automatic = true;
  #   interval = { Weekday = 0; Hour = 3; Minute = 15; };
  #   options = "--delete-older-than 14d";
  # };
  # nix.optimise.automatic = true;
  # nix.optimise.interval = { Hour = 4; Minute = 15; };
}