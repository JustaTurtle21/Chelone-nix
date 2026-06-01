{
  description = "A simple NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
       url = "github:uiriansan/SilentSDDM";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sls-steam = {
      url = "github:AceSLS/SLSsteam";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eden = {
      url = "github:Daaboulex/eden-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, affinity-nix,nixpkgs-f2k, ... }@inputs: {
    nixosConfigurations.chelone = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.justaturtle = ./home.nix;
        }
        # Imports the overlays module folder
        (import ./overlays)
      ];
    };
  };
}
