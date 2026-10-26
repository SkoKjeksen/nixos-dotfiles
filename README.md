# NixOS Dotfiles

One flake manages three computers. Run commands below from this repository's root
on a machine already running NixOS; these are not installation instructions.

## Configuration Layout

- `flake.nix`: dependencies and the named machine configurations.
- `configuration.nix`: shared system settings.
- `home.nix`: shared user applications and dotfiles, managed by Home Manager.
- `hosts/home/laptop/default.nix`: laptop settings (`laptop`).
- `hosts/home/desktop/default.nix`: desktop settings (`desktop`).
- `hosts/work/default.nix`: work settings (`work`).

Each host's `default.nix` imports its own `hardware-configuration.nix`.
System settings go directly in the host module; user settings go under
`home-manager.users.emil`, for example Git identity settings.

## Before the First Build

- Keep the checkout at `/home/emil/nixos-dotfiles`: the dotfile symlinks expect it.
- Put each computer's own hardware configuration beside its host's `default.nix`.
  On an existing NixOS installation, this is usually available at
  `/etc/nixos/hardware-configuration.nix`. Never reuse another computer's file.
- Desktop and work hardware files are not included yet; supply them before
  building those configurations.
- Preserve each machine's original `system.stateVersion`. If it differs from the
  shared value, move that setting into the host modules and set it per machine.
- Stage new files with `git add <path>` so the Git-backed flake can see them.
  A commit is not required for a local build.

## Build and Apply

Use the configuration matching the current computer. Replace `laptop` with
`desktop` or `work` as appropriate.

```sh
# Build only: does not change the running system.
nixos-rebuild build --flake .#laptop

# Activate temporarily: changes the running system, not the boot default.
sudo nixos-rebuild test --flake .#laptop

# Activate and make it the default for future boots.
sudo nixos-rebuild switch --flake .#laptop
```

After `test`, check networking, desktop login, audio, and screen unlocking before
using `switch`. Home Manager is integrated, so these commands apply both system
and user settings. No separate Home Manager command is needed.

## Recovery

To return to the previous system generation:

```sh
sudo nixos-rebuild switch --rollback
```

If the system will not boot, select an older NixOS generation in the boot menu.
Rollback does not undo edits to repository files or mutable dotfiles.