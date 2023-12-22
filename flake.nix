{\
 description = "My NixOS configs? maybe? not sure.";

 inputs = {
   # Nixpkgs
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

   # Home manager
   home-manager.url = "github:nix-community/home-manager";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";

   # Hardware
   hardware.url = "github:nixos/nixos-hardware";
 };

 outputs = { self, nixpkgs, home-manager, ... }@inputs: {
   # NixOS configuration entrypoint
   # Available through 'nixos-rebuild --flake .#your-hostname'

   nixosConfigurations = {
     # FIXME replace with your hostname
     localhost = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main nixos configuration file <
       modules = [ 
         ./nixos/configuration.nix
       ];
     };
   };

   # home-manager configuration entrypoint
   homeConfigurations = {
     "ace@localhost" = home-manager.lib.homeManagerConfiguration {
       pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
       extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main home-manager configuration file <
       modules = [ 
           ./home-manager/home.nix 
           ];
     };
   };
 };
}
