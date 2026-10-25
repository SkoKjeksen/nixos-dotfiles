

{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim";
    niri = "niri";
    wezterm = "wezterm";
    rofi = "rofi";
    noctalia = "noctalia";
};
in
{
  home.username = "emil";
  home.homeDirectory = "/home/emil";
  home.stateVersion = "26.05";
  
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia.enable = true;
  # Applications
  # programs.alacritty.enable = true;
  # programs.fuzzel.enable = true;
  programs.swaylock.enable = true;
  # programs.waybar.enable = true;

  # Services
  # services.mako.enable = true;
  programs.starship.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.git = {
      enable = true;
      userName = "Emil Nilsen";
      userEmail = "emil_n@live.no";
    };

  # Bash
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
  
  programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  # Symlink configuration files
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

gtk = {
  enable = true;
  colorScheme = "dark";

  theme = {
    name = "Gruvbox-Dark";
    package = pkgs.gruvbox-gtk-theme;
  };

  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
};
  # Packages
  home.packages = with pkgs; [
    swaybg
    xwayland-satellite
    neovim
    ripgrep
    fd
    fzf
    lazygit
    tree-sitter
    nil
    nixpkgs-fmt
    nodejs
    unzip
    rofi
    xfce.thunar
    spotify
    discord

    gdb
    gcc
    cmake
    ninja
    clang-tools
    minicom
    openocd
    usbutils
    wireshark
    distrobox

  ];
}

