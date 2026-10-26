{ ... }: {
    imports = [ ./hardware-configuration.nix ];
    networking.hostName = "emil-laptop";

    home-manager.users.emil.programs.git.settings.user = {
        name = "Emil Nilsen";
        email = "emil_n@live.no";
    };
}