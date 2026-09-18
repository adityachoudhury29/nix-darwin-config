# Wraps a daemon program so the Nix store path is mounted before it execs
# (launchd daemons can start before /nix is available at boot).
# Taken from hosts/macbook/admin_helper.nix in jagadam97/nixos-config.
{ pkgs }:
{ program, name }:

let
  script = pkgs.writeShellScript name program;
in
[
  "/bin/zsh"
  "-c"
  "/bin/wait4path ${script} && exec ${script}"
]
