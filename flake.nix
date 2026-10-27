{
description = "Emil Sin fantastiske nixOS";
inputs = {
  nixpkgs.url = "nixpkgs/nixos-26.05";
  home-manager = {
    url = "github:nix-community/home-manager/release-26.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  noctalia = {
    url = "github:noctalia-dev/noctalia";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = { nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix #Common configuration for all machines
        ./hosts/home/laptop # Laptop-specific configuration

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.emil = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.work = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix #Common configuration for all machines
        ./hosts/work # Work-specific configuration

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.emil = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix #Common configuration for all machines
        ./hosts/home/desktop # Desktop-specific configuration

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.emil = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
