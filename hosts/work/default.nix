{ pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "enilsen-akvagroup-nixos";

  nixpkgs.overlays = [
    (final: prev: {
      citrix_workspace = prev.citrix_workspace.overrideAttrs (old: {
        version = "26.04.10.1";
        src = builtins.path {
          path = ../../vendor/citrix/linuxx64-gcc-8-26.04.10.1.tar.gz;
          name = "linuxx64-gcc-8-26.04.10.1.tar.gz";
        };
      });
    })
  ];

  home-manager.users.emil.programs.git.settings.user = {
    name = "Emil Nilsen";
    email = "enilsen@akvagroup.com";
  };

  nixpkgs.config = {
    allowUnfree = true;
    segger-jlink.acceptLicense = true;

    allowInsecurePredicate = pkg:
      (lib.getName pkg == "segger-jlink-qt4")
      || (
        lib.getName pkg == "libsoup"
        && lib.getVersion pkg == "2.74.3"
      );
  };

  environment.systemPackages = with pkgs; [
    inetutils
    python3
    citrix_workspace
    gcc-arm-embedded
    cmake
    ninja
    gperf
    dtc
    ccache
    gnumake
    openocd
    dfu-util
    libusb1
    segger-jlink
  ];

  # Load SEGGER udev rules and grant seat-based user access to J-Link probes.
  services.udev.packages = [ pkgs.segger-jlink ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="1366", MODE="0666", TAG+="uaccess"
  '';

  home-manager.users.emil.programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
  };
}