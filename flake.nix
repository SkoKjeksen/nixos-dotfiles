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


outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
  nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    specialArgs = { inherit inputs; };

    modules = [
      ./configuration.nix

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
