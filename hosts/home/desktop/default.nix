{ ... }: {

    imports = [ ./hardware-configuration.nix ];
    networking.hostName = "emil-desktop";
    programs.steam.enable = true;

    home-manager.users.emil.programs.git.settings.user = {
        name = "Emil Nilsen";
        email = "emil_n@live.no";
    };
}