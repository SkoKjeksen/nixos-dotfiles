{ ... }: {
    imports = [ ./hardware-configuration.nix ];
    networking.hostName = "enilsen-akvagroup-nixos";

    home-manager.users.emil.programs.git.settings.user = {
        name = "Emil Nilsen";
        email = "enilsen@akvagroup.com";
    };
}