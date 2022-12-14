{ config, pkgs, ... }:

{

	services.flatpak.enable = true;
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;	
	};	
	environment.systemPackages = with pkgs; [
		rnnoise-plugin
		nerdfonts
		nmon
		(pkgs.systemd.overrideAttrs (oldAttrs: {
			makeFlags = [ "-O3" ];
			}))
	];
	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		rhythmbox
		gnome-console
		]) ++ (with pkgs.gnome; [
  		cheese 
  		gnome-music
  		gnome-terminal
		epiphany 
		gnome-characters
		gnome-font-viewer
		gnome-logs
		totem
		gnome-maps
		yelp
		]);	
}
